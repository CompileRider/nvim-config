-- Todo-comments - Highlight and search todo comments
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("todo-comments").setup({
      -- Sign configuration
      signs = true,
      sign_priority = 8,
      
      -- Keywords configuration
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { 
          icon = " ", 
          color = "info" 
        },
        HACK = { 
          icon = " ", 
          color = "warning" 
        },
        WARN = { 
          icon = " ", 
          color = "warning", 
          alt = { "WARNING", "XXX" } 
        },
        PERF = { 
          icon = " ", 
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } 
        },
        NOTE = { 
          icon = " ", 
          color = "hint", 
          alt = { "INFO" } 
        },
        TEST = { 
          icon = "⏲ ", 
          color = "test", 
          alt = { "TESTING", "PASSED", "FAILED" } 
        },
      },
      
      -- GUI style configuration
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      
      -- Merge with defaults
      merge_keywords = true,
      
      -- Highlighting configuration
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      
      -- Color configuration
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      
      -- Search configuration
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    })

    -- Keymaps for navigation
    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })

    -- Keymaps for searching
    vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo Comments" })
    vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme" })
  end,
}
