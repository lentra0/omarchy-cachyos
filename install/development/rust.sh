#!/bin/bash

# Install rustup
paru -S --noconfirm --needed rust

# Add toolchain
rustup default stable
rustup toolchain install stable

# Print version
rustc -V

# Install additional components
rustup update
rustup component add rust-analyzer
rustup component add rust-src
