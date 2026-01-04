-- Which-key - Keymap discovery and help system
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "classic",
      -- Delay configuration
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      -- Filter mappings
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      -- Notification settings
      notify = true,
      -- Trigger configuration
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      -- Defer configuration
      defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
      -- Plugin settings
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      -- Window configuration
      win = {
        no_overlap = true,
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {
          winblend = 10,
        },
      },
      -- Layout settings
      layout = {
        width = { min = 20 },
        spacing = 3,
      },
      -- Key bindings for popup
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      -- Sorting configuration
      sort = { "local", "order", "group", "alphanum", "mod" },
      -- Expand settings
      expand = 0,
      -- Text replacement rules
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      -- Icon configuration
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫", F2 = "󱊬", F3 = "󱊭", F4 = "󱊮",
          F5 = "󱊯", F6 = "󱊰", F7 = "󱊱", F8 = "󱊲",
          F9 = "󱊳", F10 = "󱊴", F11 = "󱊵", F12 = "󱊶",
        },
      },
      -- Display settings
      show_help = true,
      show_keys = true,
      -- Disable for certain buffer types
      disable = {
        ft = {},
        bt = {},
      },
      debug = false,
    })

    -- Key mappings and groups
    wk.add({
      -- File operations
      { "<leader>f", group = "File" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
      
      -- Buffer operations
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
      { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
      { "<leader>ba", "<cmd>%bd|e#<cr>", desc = "Delete All But Current" },
      
      -- Window operations
      { "<leader>w", proxy = "<c-w>", group = "Window" },
      
      -- Git operations
      { "<leader>g", group = "Git" },
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git log<cr>", desc = "Git Log" },
      
      -- LSP operations
      { "<leader>l", group = "LSP" },
      { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
      { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      
      -- Search operations
      { "<leader>s", group = "Search" },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search Word" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      
      -- Toggle operations
      { "<leader>t", group = "Toggle" },
      { "<leader>tn", "<cmd>set number!<cr>", desc = "Toggle Line Numbers" },
      { "<leader>tr", "<cmd>set relativenumber!<cr>", desc = "Toggle Relative Numbers" },
      { "<leader>tw", "<cmd>set wrap!<cr>", desc = "Toggle Word Wrap" },
      { "<leader>ts", "<cmd>set spell!<cr>", desc = "Toggle Spell Check" },
      
      -- Quit operations
      { "<leader>q", group = "Quit" },
      { "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },
      { "<leader>qw", "<cmd>wqa<cr>", desc = "Save and Quit All" },
      { "<leader>qf", "<cmd>qa!<cr>", desc = "Force Quit All" },
    })

    -- Additional keymap for buffer local mappings
    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Buffer Local Keymaps" })
  end,
}
