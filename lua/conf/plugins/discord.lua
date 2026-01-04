return {
  "vyfor/cord.nvim",
  build = "./build",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "neovim",
      tooltip = "The Superior Text Editor",
    },
    display = {
      show_time = true,
      show_repository = true,
      show_cursor_position = false,
      swap_fields = false,
      swap_icons = false,
    },
    lsp = {
      show_problem_count = true,
    },
    idle = {
      enable = true,
      timeout = 300000, -- 5 minutes
      show_status = true,
      ignore_focus = true,
      details = "Idle",
      state = "Taking a break",
    },
    text = {
      viewing = "Viewing {}",
      editing = "Editing {}",
      file_browser = "Browsing files",
      plugin_manager = "Managing plugins",
      workspace = "In {}",
    },
    assets = {
      -- Custom icons for languages (optional)
      -- c = { icon = "c", tooltip = "C", name = "C" },
    },
  },
}
