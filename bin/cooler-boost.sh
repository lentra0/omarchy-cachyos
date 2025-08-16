
#!/usr/bin/bash
# Автовключение/выключение Cooler Boost по температуре с уведомлениями dunstify.
# Порог ON: 85°C, порог OFF: 60°C, проверка каждые 5 секунд.
# D-Bus: mcontrolcenter.helper / dmitry_s93.MControlCenter.putValue(address=152, value=0|128)

# --- Настройки ---
SERVICE="mcontrolcenter.helper"
INTERFACE="dmitry_s93.MControlCenter"
ADDRESS=152
ON_VALUE=128
OFF_VALUE=0

ON_THRESHOLD=82
OFF_THRESHOLD=60
INTERVAL=5

DUNST_ID=99123  # id для замены уведомлений, чтобы не спамить

# --- Один экземпляр ---
exec 9>/tmp/cooler-boost.lock
flock -n 9 || exit 0

# --- Инструменты ---
QDBUS="$(command -v qdbus || true)"
DUNSTIFY="$(command -v dunstify || true)"
[ -z "$QDBUS" ] && exit 0  # без qdbus работать не можем

# --- Утилиты ---
notify_state() {
  # $1: "ON" или "OFF"
  [ -n "$DUNSTIFY" ] && "$DUNSTIFY" -a "Thermals" -r "$DUNST_ID" -u low "Cooler Boost: $1" >/dev/null 2>&1
}

is_ec_loaded() {
  # true/false (по выходному коду)
  $QDBUS --system "$SERVICE" / "$INTERFACE.isEcSysModuleLoaded" 2>/dev/null | grep -qi true
}

load_ec() {
  $QDBUS --system "$SERVICE" / "$INTERFACE.loadEcSysModule" >/dev/null 2>&1
}

cb_set() {
  # $1: значение (0|128)
  $QDBUS --system "$SERVICE" / "$INTERFACE.putValue" "$ADDRESS" "$1" >/dev/null 2>&1
}

read_temp_max() {
  # Возвращает максимальную температуру (целое, °C), либо пустую строку при неудаче
  local max=-1000 val
  shopt -s nullglob
  for f in /sys/class/thermal/thermal_zone*/temp; do
    read -r val < "$f" || continue
    # Значение обычно в миллиградусах
    if [ "$val" -gt 1000 ]; then
      val=$(( val / 1000 ))
    fi
    [ "$val" -gt "$max" ] && max="$val"
  done
  [ "$max" -eq -1000 ] && echo "" || echo "$max"
}

service_ready() {
  # Проверяем, что сервис доступен (Ping проходит)
  $QDBUS --system "$SERVICE" / org.freedesktop.DBus.Peer.Ping >/dev/null 2>&1
}

# --- Подготовка ---
# Тихо пытаемся обеспечить готовность: сервис доступен и модуль ec_sys загружен.
if service_ready; then
  is_ec_loaded || load_ec
fi

# На выходе — выключить буст (тихо), чтобы не залип.
cleanup() {
  cb_set "$OFF_VALUE"
}
trap cleanup EXIT

# --- Основной цикл ---
state="unknown"  # "on" | "off" | "unknown"

while :; do
  # Если сервис недоступен — следующая попытка позже
  if ! service_ready; then
    sleep "$INTERVAL"
    continue
  fi

  # Убедиться, что ec_sys загружен
  is_ec_loaded || load_ec

  temp="$(read_temp_max)"
  if [ -z "$temp" ]; then
    sleep "$INTERVAL"
    continue
  fi

  if [ "$temp" -ge "$ON_THRESHOLD" ]; then
    if [ "$state" != "on" ]; then
      if cb_set "$ON_VALUE"; then
        state="on"
        notify_state "ON"
      fi
    fi
  elif [ "$temp" -le "$OFF_THRESHOLD" ]; then
    if [ "$state" != "off" ]; then
      if cb_set "$OFF_VALUE"; then
        state="off"
        notify_state "OFF"
      fi
    fi
  fi

  sleep "$INTERVAL"
done
