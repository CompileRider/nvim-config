-- Telescope File Browser: Advanced file navigation with path completion
return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      extensions = {
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              -- your custom insert mode mappings
            },
            ['n'] = {
              -- your custom normal mode mappings
            },
          },
          -- path
          path = '%:p:h',
          cwd = vim.fn.expand('%:p:h'),
          cwd_to_path = false,
          grouped = false,
          files = true,
          add_dirs = true,
          depth = 1,
          auto_depth = false,
          select_buffer = false,
          hidden = { file_browser = false, folder_browser = false },
          respect_gitignore = vim.fn.executable('fd') == 1,
          no_ignore = false,
          follow_symlinks = false,
          browse_files = require('telescope._extensions.file_browser.finders').browse_files,
          browse_folders = require('telescope._extensions.file_browser.finders').browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = '',
          dir_icon_hl = 'Default',
          display_stat = { date = true, size = true, mode = true },
          hijack_netrw = true,
          use_fd = true,
          git_status = true,
        },
      },
    })
    
    require('telescope').load_extension('file_browser')
    
    -- Keymaps
    vim.keymap.set('n', '<space>fb', ':Telescope file_browser<CR>', { desc = 'File Browser' })
    vim.keymap.set('n', '<space>fB', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = 'File Browser (current buffer dir)' })
  end,
}
