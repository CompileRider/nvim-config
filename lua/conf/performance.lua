-- Performance optimizations for Neovim
-- Disable unused providers for faster startup
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Faster file operations
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Memory optimizations
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 240

-- Faster scrolling (removed lazyredraw due to Noice conflict)
vim.opt.ttyfast = true

-- Reduce startup time
vim.opt.shadafile = "NONE"
vim.defer_fn(function()
  vim.opt.shadafile = ""
  vim.cmd("rshada!")
end, 100)

-- Faster grep
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
end
