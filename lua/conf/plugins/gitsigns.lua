return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
  keys = {
    -- Navigation between hunks
    { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next git hunk" },
    { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Previous git hunk" },
    
    -- Hunk actions
    { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
    { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
    { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
    { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
    
    -- Preview and diff
    { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },
    { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
    { "<leader>hD", function() require("gitsigns").diffthis("~") end, desc = "Diff this ~" },
    
    -- Blame
    { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },
    { "<leader>hB", "<cmd>Gitsigns blame<cr>", desc = "Blame buffer" },
    
    -- Toggles
    { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    { "<leader>tD", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle deleted lines" },
    { "<leader>tw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Toggle word diff" },
    
    -- Quickfix/Location list
    { "<leader>hq", "<cmd>Gitsigns setqflist<cr>", desc = "Git hunks to quickfix" },
    { "<leader>hQ", function() require("gitsigns").setqflist("all") end, desc = "All git hunks to quickfix" },
    
    -- Visual mode hunk actions
    { "<leader>hs", function() require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, mode = "v", desc = "Stage selected hunk" },
    { "<leader>hr", function() require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, mode = "v", desc = "Reset selected hunk" },
  },
  opts = {
    -- Beautiful modern signs with rounded corners
    signs = {
      add          = { text = "▎" }, -- Thick left border for additions
      change       = { text = "▎" }, -- Consistent with additions
      delete       = { text = "" }, -- Subtle triangle for deletions
      topdelete    = { text = "" }, -- Top triangle for top deletions
      changedelete = { text = "▎" }, -- Mixed change/delete
      untracked    = { text = "┆" }, -- Dotted line for untracked
    },
    
    -- Staged signs for enhanced workflow
    signs_staged = {
      add          = { text = "▌" }, -- Slightly different for staged
      change       = { text = "▌" },
      delete       = { text = "" },
      topdelete    = { text = "" },
      changedelete = { text = "▌" },
      untracked    = { text = "┆" },
    },
    
    signs_staged_enable = true,
    signcolumn = true,  -- Always show sign column for consistency
    numhl = false,      -- Don't highlight line numbers by default
    linehl = false,     -- Don't highlight entire lines by default
    word_diff = false,  -- Enable with toggle
    
    -- Watch git directory for changes
    watch_gitdir = {
      follow_files = true, -- Follow files when they move
    },
    
    auto_attach = true,
    attach_to_untracked = true, -- Show signs for untracked files
    
    -- Current line blame configuration
    current_line_blame = false, -- Start disabled, toggle with keymap
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- End of line positioning
      delay = 500, -- Faster response than default
      ignore_whitespace = true, -- Ignore whitespace changes
      virt_text_priority = 100,
      use_focus = true, -- Only show when window is focused
    },
    
    -- Beautiful blame formatter with icons
    current_line_blame_formatter = " 󰊢 <author> • <author_time:%R> • <summary>",
    
    sign_priority = 6, -- Higher than most other signs
    update_debounce = 50, -- Faster updates for responsive feel
    
    -- Status formatter for statusline integration
    status_formatter = function(status)
      local added = status.added and status.added > 0 and ("+" .. status.added) or ""
      local changed = status.changed and status.changed > 0 and ("~" .. status.changed) or ""
      local removed = status.removed and status.removed > 0 and ("-" .. status.removed) or ""
      
      local parts = {}
      if added ~= "" then table.insert(parts, added) end
      if changed ~= "" then table.insert(parts, changed) end
      if removed ~= "" then table.insert(parts, removed) end
      
      return table.concat(parts, " ")
    end,
    
    max_file_length = 40000, -- Disable for very large files
    
    -- Beautiful preview window configuration
    preview_config = {
      border = "rounded", -- Consistent with other floating windows
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
      focusable = false,
    },
    
    -- Enhanced on_attach for buffer-specific keymaps
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      
      -- Text object for hunks
      vim.keymap.set({"o", "x"}, "ih", "<cmd>Gitsigns select_hunk<cr>", 
        { buffer = bufnr, desc = "Select git hunk" })
      
      -- Smart navigation that works with diff mode
      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({"]c", bang = true})
        else
          gitsigns.nav_hunk("next")
        end
      end, { buffer = bufnr, desc = "Next change" })
      
      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({"[c", bang = true})
        else
          gitsigns.nav_hunk("prev")
        end
      end, { buffer = bufnr, desc = "Previous change" })
    end,
  },
  
  config = function(_, opts)
    require("gitsigns").setup(opts)
    
    -- Enhanced highlights for beautiful appearance
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Git signs with modern colors (Catppuccin-inspired)
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6e3a1", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#f9e2af", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f38ba8", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#6c7086", bg = "NONE" })
        
        -- Staged signs with slightly different colors
        vim.api.nvim_set_hl(0, "GitSignsAddStaged", { fg = "#94e2d5", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChangeStaged", { fg = "#fab387", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteStaged", { fg = "#eba0ac", bg = "NONE" })
        
        -- Current line blame with subtle styling
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { 
          fg = "#6c7086", 
          bg = "NONE", 
          italic = true 
        })
        
        -- Word diff highlights
        vim.api.nvim_set_hl(0, "GitSignsAddInline", { 
          fg = "#1e1e2e", 
          bg = "#a6e3a1" 
        })
        vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { 
          fg = "#1e1e2e", 
          bg = "#f38ba8" 
        })
        vim.api.nvim_set_hl(0, "GitSignsChangeInline", { 
          fg = "#1e1e2e", 
          bg = "#f9e2af" 
        })
      end,
    })
    
    -- Trigger highlight setup immediately
    vim.cmd("doautocmd ColorScheme")
    
    -- Create autocommands for git operation notifications
    vim.api.nvim_create_autocmd("User", {
      pattern = "GitSignsUpdate",
      callback = function()
        -- Optional: Notify when git status updates
        -- This could be made configurable
      end,
    })
    
    -- Add statusline integration
    vim.g.gitsigns_status_dict = {}
    vim.api.nvim_create_autocmd("User", {
      pattern = "GitSignsUpdate",
      callback = function()
        vim.g.gitsigns_status_dict = vim.b.gitsigns_status_dict or {}
      end,
    })
  end,
}
