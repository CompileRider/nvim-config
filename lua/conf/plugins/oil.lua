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
        ["<CR>"] = "actions.select", -- Enter: abrir archivo/directorio
        ["<C-s>"] = { "actions.select", opts = { vertical = true } }, -- Ctrl+s: split vertical
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } }, -- Ctrl+h: split horizontal
        ["<C-t>"] = { "actions.select", opts = { tab = true } }, -- Ctrl+t: nueva pestaña
        ["<C-p>"] = "actions.preview", -- Ctrl+p: preview
        ["<C-c>"] = "actions.close", -- Ctrl+c: cerrar
        ["<C-l>"] = "actions.refresh", -- Ctrl+l: refrescar
        ["-"] = "actions.parent", -- -: directorio padre
        ["_"] = "actions.open_cwd", -- _: directorio de trabajo
        ["`"] = "actions.cd", -- `: cambiar directorio
        ["~"] = { "actions.cd", opts = { scope = "tab" } }, -- ~: cambiar directorio en pestaña
        ["gs"] = "actions.change_sort", -- gs: cambiar orden
        ["gx"] = "actions.open_external", -- gx: abrir con aplicación externa
        ["g."] = "actions.toggle_hidden", -- g.: mostrar/ocultar archivos ocultos
        ["g\\"] = "actions.toggle_trash", -- g\: mostrar/ocultar papelera
        -- Teclas adicionales para navegación rápida
        ["l"] = "actions.select", -- l: entrar a archivo/directorio (como vim)
        ["h"] = "actions.parent", -- h: directorio padre (como vim)
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
