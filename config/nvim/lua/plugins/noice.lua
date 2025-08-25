return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        filter = {
          any = {
            { event = "msg_show", kind = "" },
            { event = "notify", kind = "" },
          },
        },
        opts = { skip = true },
      },
    },
  },
}
