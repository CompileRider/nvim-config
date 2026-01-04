return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "neovim",
      tooltip = "The Superior Text Editor",
      icon = "https://raw.githubusercontent.com/CompileRider/nvim-config/main/discord_avatar.jpg",
    },
    display = {
      theme = "catppuccin",
      flavor = "dark",  -- "dark", "light", o "accent"
      swap_fields = false,
      swap_icons = false,
    },
    timestamp = {
      enabled = true,
      reset_on_idle = false,
      reset_on_change = false,
    },
    idle = {
      enabled = true,
      timeout = 300000,
      show_status = true,
      ignore_focus = true,
      unidle_on_focus = true,
      smart_idle = true,
      details = "Idling",
      state = nil,
      tooltip = "💤",
    },
    text = {
      workspace = function(opts) return "In " .. opts.workspace end,
      viewing = function(opts) return "Viewing " .. opts.filename end,
      editing = function(opts) return "Editing " .. opts.filename end,
      file_browser = function(opts) return "Browsing files in " .. opts.name end,
      plugin_manager = function(opts) return "Managing plugins in " .. opts.name end,
      lsp = function(opts) return "Configuring LSP in " .. opts.name end,
      docs = function(opts) return "Reading " .. opts.name end,
      vcs = function(opts) return "Committing changes in " .. opts.name end,
      terminal = function(opts) return "Running commands in " .. opts.name end,
      dashboard = "Home",
    },
    buttons = {
      {
        label = function(opts)
          return opts.repo_url and "View Repository" or nil
        end,
        url = function(opts) return opts.repo_url end,
      },
    },
    plugins = {
      ["cord.plugins.diagnostics"] = {
        scope = "buffer",
        severity = { min = vim.diagnostic.severity.WARN },
        override = true,
      },
    },
    hooks = {
      post_activity = function(_, activity)
        -- Override large image with custom image
        activity.assets.large_image = "https://raw.githubusercontent.com/CompileRider/nvim-config/main/discord_avatar.jpg"
        activity.assets.large_text = "Neovim"
        -- Show Neovim version in small icon tooltip
        local version = vim.version()
        activity.assets.small_text = string.format(
          "Neovim %s.%s.%s",
          version.major,
          version.minor,
          version.patch
        )
      end,
    },
  },
}
