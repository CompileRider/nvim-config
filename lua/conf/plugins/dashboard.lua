-------------------------------------------------------------------------------
-- Dashboard - Rust Development Environment 🦀
-------------------------------------------------------------------------------
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Rust gradient: orange → rust → brown
    local colors = {
      { "DashboardHeader1", "#FF8C00" },
      { "DashboardHeader2", "#E45A28" },
      { "DashboardHeader3", "#CE412B" },
      { "DashboardHeader4", "#B7410E" },
    }
    for _, c in ipairs(colors) do
      vim.api.nvim_set_hl(0, c[1], { fg = c[2], bold = true })
    end

    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = { enable = false },
        header = {
          "",
          " ██████╗ ██╗   ██╗███████╗████████╗ █████╗  ██████╗███████╗ █████╗ ███╗   ██╗",
          " ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔════╝██╔══██╗████╗  ██║",
          " ██████╔╝██║   ██║███████╗   ██║   ███████║██║     █████╗  ███████║██╔██╗ ██║",
          " ██╔══██╗██║   ██║╚════██║   ██║   ██╔══██║██║     ██╔══╝  ██╔══██║██║╚██╗██║",
          " ██║  ██║╚██████╔╝███████║   ██║   ██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║",
          " ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝",
          "",
          "                    🦀 RUST DEVELOPMENT ENVIRONMENT 🦀                    ",
          "",
        },
        shortcut = {
          { desc = "󰈞 Find", group = "@property", action = "Telescope find_files", key = "f" },
          { desc = " New", group = "@property", action = "enew", key = "n" },
          { desc = "󰈢 Recent", group = "@property", action = "Telescope oldfiles", key = "r" },
          { desc = "󰈬 Grep", group = "@property", action = "Telescope live_grep", key = "g" },
          { desc = " Cargo", group = "@property", action = "edit Cargo.toml", key = "C" },
          { desc = "󰗼 Quit", group = "@property", action = "qa", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          return { "", "🦀 FEARLESS CONCURRENCY 🦀", "", ("⚡ %d/%d plugins in %.2fms"):format(stats.loaded, stats.count, stats.startuptime) }
        end,
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
          if line:match("██") then
            vim.api.nvim_buf_add_highlight(buf, -1, "DashboardHeader" .. math.min(4, math.max(1, i - 1)), i - 1, 0, -1)
          end
        end
        vim.opt_local.cursorline = false
      end,
    })
  end,
}
