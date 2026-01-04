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

-- Clangd extensions (loaded on FileType c,cpp)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  callback = function()
    keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
    keymap("n", "<A-i>", "<cmd>ClangdSymbolInfo<cr>", opts)
    keymap("n", "<A-t>", "<cmd>ClangdTypeHierarchy<cr>", opts)
    keymap("n", "<A-m>", "<cmd>ClangdMemoryUsage<cr>", opts)
    keymap("n", "<A-a>", "<cmd>ClangdAST<cr>", opts)
  end,
})

-- CMake (loaded on FileType cmake)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "cmake" },
  callback = function()
    keymap("n", "<F5>", "<cmd>CMakeGenerate<cr>", opts)
    keymap("n", "<F6>", "<cmd>CMakeBuild<cr>", opts)
    keymap("n", "<F7>", "<cmd>CMakeRun<cr>", opts)
    keymap("n", "<F8>", "<cmd>CMakeDebug<cr>", opts)
    keymap("n", "<F9>", "<cmd>CMakeClean<cr>", opts)
    keymap("n", "<C-m>g", "<cmd>CMakeGenerate<cr>", opts)
    keymap("n", "<C-m>b", "<cmd>CMakeBuild<cr>", opts)
    keymap("n", "<C-m>r", "<cmd>CMakeRun<cr>", opts)
    keymap("n", "<C-m>c", "<cmd>CMakeClean<cr>", opts)
    keymap("n", "<C-m>s", "<cmd>CMakeSwitch<cr>", opts)
    keymap("n", "<C-m>o", "<cmd>CMakeOpen<cr>", opts)
    keymap("n", "<C-m>t", "<cmd>CMakeSelectTarget<cr>", opts)
  end,
})

-- Refactoring (loaded on FileType c,cpp)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    keymap("v", "<F10>", function() require('refactoring').refactor('Extract Function') end, opts)
    keymap("v", "<F11>", function() require('refactoring').refactor('Extract Variable') end, opts)
    keymap("v", "<F12>", function() require('refactoring').refactor('Inline Variable') end, opts)
    keymap("n", "<C-r>f", function() require('refactoring').refactor('Extract Block') end, opts)
    keymap("n", "<C-r>i", function() require('refactoring').refactor('Inline Function') end, opts)
    keymap("n", "<C-r>p", function() require('refactoring').debug.printf({below = false}) end, opts)
    keymap("n", "<C-r>v", function() require('refactoring').debug.print_var({normal = true}) end, opts)
    keymap("v", "<C-r>v", function() require('refactoring').debug.print_var({}) end, opts)
    keymap("n", "<C-r>c", function() require('refactoring').debug.cleanup({}) end, opts)
    
    -- DAP keymaps
    keymap("n", "<F9>", function() require('dap').toggle_breakpoint() end, opts)
    keymap("n", "<F5>", function() require('dap').continue() end, opts)
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
