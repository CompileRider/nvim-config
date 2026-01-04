return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
    { "<leader>gg", function() _G.lazygit_toggle() end, desc = "Lazygit" },
  },
  
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = -30,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    auto_scroll = true,
    
    float_opts = {
      border = "rounded",
      width = 120,
      height = 30,
      winblend = 10,
      zindex = 50,
      title_pos = "center",
    },
    
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return string.format(" Terminal %d ", term.id)
      end
    },
  },
  
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- Terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0, silent = true }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end
    
    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
    
    -- Lazygit terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      float_opts = {
        border = "rounded",
        width = 140,
        height = 35,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", 
          { noremap = true, silent = true })
      end,
    })
    
    function _G.lazygit_toggle()
      lazygit:toggle()
    end
  end,
}
