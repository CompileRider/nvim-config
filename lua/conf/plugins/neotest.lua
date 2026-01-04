return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-python'),
        require('neotest-plenary').setup({
          min_init = './scripts/tests/minimal.vim',
        }),
      },
    })

    vim.keymap.set('n', '<leader>tt', function()
      require('neotest').run.run()
    end)
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand('%'))
    end)
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end)
  end,
}
