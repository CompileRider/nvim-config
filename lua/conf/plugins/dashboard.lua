-- Dashboard: Startup screen with Bare Metal theme
-- Custom ASCII header with gradient colors and quick shortcuts
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("dashboard")
    
    -- Gradient highlight groups (gold to orange)
    vim.api.nvim_set_hl(0, "DashboardHeader1", { fg = "#FFD700", bold = true })
    vim.api.nvim_set_hl(0, "DashboardHeader2", { fg = "#FFA500", bold = true })
    vim.api.nvim_set_hl(0, "DashboardHeader3", { fg = "#FF8C00", bold = true })
    vim.api.nvim_set_hl(0, "DashboardHeader4", { fg = "#FF6347", bold = true })
    vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#FF6B35", italic = true })
    vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#7AA2F7" })
    vim.api.nvim_set_hl(0, "DashboardShortcut", { fg = "#9ECE6A", bold = true })
    
    local header = {
      [[                                                                       ]],
      [[  ██████╗  █████╗ ██████╗ ███████╗    ███╗   ███╗███████╗████████╗ █████╗ ██╗     ]],
      [[ ██╔══██╗██╔══██╗██╔══██╗██╔════╝    ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██║     ]],
      [[ ██████╔╝███████║██████╔╝█████╗      ██╔████╔██║█████╗     ██║   ███████║██║     ]],
      [[ ██╔══██╗██╔══██║██╔══██╗██╔══╝      ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║     ]],
      [[ ██████╔╝██║  ██║██║  ██║███████╗    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████╗]],
      [[ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝]],
      [[                                                                       ]],
      [[                        ⚡ C DEVELOPMENT ENVIRONMENT ⚡                 ]],
      [[                                                                       ]],
    }
    
    dashboard.setup({
      theme = "hyper",
      config = {
        week_header = { enable = false },
        shortcut = {
          { desc = "󰈞  Find File", group = "DashboardShortcut", action = "Telescope find_files", key = "f" },
          { desc = "  New File", group = "DashboardShortcut", action = "enew", key = "n" },
          { desc = "󰈢  Recent Files", group = "DashboardShortcut", action = "Telescope oldfiles", key = "r" },
          { desc = "󰈬  Find Text", group = "DashboardShortcut", action = "Telescope live_grep", key = "g" },
          { desc = "  Configuration", group = "DashboardShortcut", action = "edit ~/.config/nvim/init.lua", key = "c" },
          { desc = "󰁯  Restore Session", group = "DashboardShortcut", action = "lua require('auto-session').RestoreSession()", key = "s" },
          { desc = "󰗼  Quit", group = "DashboardShortcut", action = "qa", key = "q" },
        },
        header = header,
        footer = { "", "🔥 BARE METAL C PROGRAMMING 🔥", "Performance • Precision • Power", "", "⚡ Lightning Fast • 🎯 Pixel Perfect • 🔧 Bare Metal Ready" }
      }
    })
    
    -- Apply gradient colors instantly
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
        
        for i, line in ipairs(lines) do
          if line:match("██") then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardHeader" .. math.min(4, math.max(1, i - 2)), i - 1, 0, -1)
          elseif line:match("⚡.*⚡") then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardCenter", i - 1, 0, -1)
          elseif line:match("🔥.*🔥") or line:match("⚡.*🔧") then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardFooter", i - 1, 0, -1)
          end
        end
        
        vim.opt_local.cursorline = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
      end,
    })
    
    -- Reapply colors on resize
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "dashboard" then
          local buf = vim.api.nvim_get_current_buf()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
          
          for i, line in ipairs(lines) do
            if line:match("██") then
              vim.api.nvim_buf_add_highlight(buf, -1, "DashboardHeader" .. math.min(4, math.max(1, i - 2)), i - 1, 0, -1)
            elseif line:match("⚡.*⚡") then
              vim.api.nvim_buf_add_highlight(buf, -1, "DashboardCenter", i - 1, 0, -1)
            elseif line:match("🔥.*🔥") or line:match("⚡.*🔧") then
              vim.api.nvim_buf_add_highlight(buf, -1, "DashboardFooter", i - 1, 0, -1)
            end
          end
        end
      end,
    })
    
    -- Display startup time
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.setup({
          config = { footer = { "", "🔥 BARE METAL C PROGRAMMING 🔥", "Performance • Precision • Power", "", "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms ⚡" } }
        })
      end,
    })
  end,
}
