-- Noice: Modern UI for messages, cmdline, and popupmenu
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      format = {
        cmdline = { pattern = "^:", icon = " ", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = " $", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰋖" },
        input = {},
      },
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
      kind_icons = {},
    },
    lsp = {
      progress = { enabled = true },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true, silent = false },
      signature = { enabled = true, auto_open = { enabled = true, trigger = true, throttle = 50 } },
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },
    views = {
      cmdline_popup = {
        position = { row = 5, col = "50%" },
        size = { width = 60, height = "auto" },
        border = { style = "rounded", padding = { 0, 1 } },
        win_options = {
          winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 8, col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded", padding = { 0, 1 } },
        win_options = {
          winhighlight = { Normal = "NormalFloat", FloatBorder = "DiagnosticInfo" },
        },
      },
      hover = {
        border = { style = "rounded" },
        position = { row = 2, col = 2 },
      },
    },
    routes = {
      { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "", find = "%d+L, %d+B" }, view = "mini" },
      { filter = { event = "msg_show", kind = "", find = "fewer lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "", find = "more lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "", find = "search hit" }, opts = { skip = true } },
      { filter = { event = "msg_showmode" }, view = "notify" },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
