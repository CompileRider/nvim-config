-------------------------------------------------------------------------------
-- Discord Rich Presence (cord.nvim)
-- Shows coding activity in Discord with custom branding
-------------------------------------------------------------------------------
return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "1457478127566459078", -- Bare Metal Discord App ID
      tooltip = "touching bare metal",
    },
    display = {
      theme = "catppuccin",
      flavor = "dark",
      swap_icons = true, -- Language icon as small, custom image as large
    },
    timestamp = { enabled = true },
    idle = {
      enabled = true,
      timeout = 300000, -- 5 minutes
      show_status = true,
      smart_idle = true,
      details = function(opts)
        return opts.workspace and ("Idle in " .. opts.workspace) or "Idling"
      end,
      tooltip = "💤",
    },
    text = {
      workspace = function(opts) return "In " .. opts.workspace end,
      viewing = function(opts)
        local mod = vim.bo.modified and " [+]" or ""
        return "Viewing " .. opts.filename .. mod .. " " .. opts.cursor_line .. ":" .. opts.cursor_char
      end,
      editing = function(opts)
        local mod = vim.bo.modified and " [+]" or ""
        return "Editing " .. opts.filename .. mod .. " " .. opts.cursor_line .. ":" .. opts.cursor_char
      end,
      file_browser = function(opts) return "Browsing " .. opts.name end,
      plugin_manager = function(opts) return "Managing plugins" end,
      vcs = function(opts) return "Git: " .. opts.name end,
      terminal = function(opts) return "Terminal" end,
      dashboard = "Home",
    },
    buttons = {
      { label = function(opts) return opts.repo_url and "View Repository" end, url = function(opts) return opts.repo_url end },
    },
    plugins = {
      ["cord.plugins.diagnostics"] = { scope = "buffer", severity = { min = vim.diagnostic.severity.WARN } },
    },
    advanced = {
      discord = { reconnect = { enabled = true, interval = 5000, initial = true } },
    },
    hooks = {
      post_activity = function(_, activity)
        activity.assets.large_image = "https://i.imgur.com/aDdzldp.png"
        activity.assets.large_text = "Bare Metal"
        local v = vim.version()
        activity.assets.small_text = ("Neovim %d.%d.%d"):format(v.major, v.minor, v.patch)
      end,
    },
  },
}
