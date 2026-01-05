local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymap("n", "Q", "<nop>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "p", '"_dP', opts)

-- Terminal
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- LSP (loaded on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap("n", "K", vim.lsp.buf.hover, bufopts)
    keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap("n", "gr", vim.lsp.buf.references, bufopts)
    keymap("n", "<F2>", vim.lsp.buf.rename, bufopts)
    keymap("n", "<F4>", vim.lsp.buf.code_action, bufopts)
  end,
})

-- Rust keymaps (loaded on FileType rust)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    -- Cargo commands
    keymap("n", "<F5>", "<cmd>CargoRun<cr>", opts)
    keymap("n", "<F6>", "<cmd>CargoBuild<cr>", opts)
    keymap("n", "<F7>", "<cmd>CargoTest<cr>", opts)
    keymap("n", "<F8>", "<cmd>CargoClippy<cr>", opts)
    -- DAP
    keymap("n", "<F9>", function() require('dap').toggle_breakpoint() end, opts)
    keymap("n", "<F10>", function() require('dap').step_over() end, opts)
    keymap("n", "<F11>", function() require('dap').step_into() end, opts)
    keymap("n", "<F12>", function() require('dap').step_out() end, opts)
  end,
})

-- Quickfix navigation
keymap("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix" })
keymap("n", "[q", "<cmd>cprev<cr>zz", { desc = "Prev quickfix" })
keymap("n", "]Q", "<cmd>clast<cr>zz", { desc = "Last quickfix" })
keymap("n", "[Q", "<cmd>cfirst<cr>zz", { desc = "First quickfix" })

-- Diagnostic navigation
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
