-- Oil.nvim - File explorer with buffer-like editing
return {
  "stevearc/oil.nvim",
  lazy = false, -- Load immediately to prevent delays
  priority = 1000, -- High priority for instant access
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon" },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      -- Performance settings
      cleanup_delay_ms = 0, -- Instant buffer cleanup
      lsp_file_methods = {
        timeout_ms = 50, -- Balanced timeout for LSP operations
        autosave_changes = false,
      },
      constrain_cursor = "editable",
      watch_for_changes = false,
      keymaps = {
        ["<CR>"] = "actions.select", -- Enter: open file/directory
        ["<C-s>"] = { "actions.select", opts = { vertical = true } }, -- Ctrl+s: vertical split
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } }, -- Ctrl+h: horizontal split
        ["<C-t>"] = { "actions.select", opts = { tab = true } }, -- Ctrl+t: new tab
        ["<C-p>"] = "actions.preview", -- Ctrl+p: preview
        ["<C-c>"] = "actions.close", -- Ctrl+c: close
        ["<C-l>"] = "actions.refresh", -- Ctrl+l: refresh
        ["-"] = "actions.parent", -- -: parent directory
        ["_"] = "actions.open_cwd", -- _: working directory
        ["`"] = "actions.cd", -- `: change directory
        ["~"] = { "actions.cd", opts = { scope = "tab" } }, -- ~: change directory (tab scope)
        ["gs"] = "actions.change_sort", -- gs: change sort
        ["gx"] = "actions.open_external", -- gx: open with external app
        ["g."] = "actions.toggle_hidden", -- g.: toggle hidden files
        ["g\\"] = "actions.toggle_trash", -- g\: toggle trash
        -- Additional keys for quick navigation
        ["l"] = "actions.select", -- l: enter file/directory (vim-like)
        ["h"] = "actions.parent", -- h: parent directory (vim-like)
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          if name == ".." then
            return false
          end
          return vim.startswith(name, ".")
        end,
        natural_order = true,
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      git = {
        add = function() return false end,
        mv = function() return false end,
        rm = function() return false end,
      },
      float = {
        padding = 2,
        max_width = 80,
        border = "rounded",
        win_options = { winblend = 0 },
      },
      preview = {
        update_on_cursor_moved = false,
      },
    })

    -- Keymaps
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })
  end,
}
