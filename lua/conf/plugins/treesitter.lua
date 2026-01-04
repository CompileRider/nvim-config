-- Treesitter: Syntax highlighting and code understanding
-- Provides enhanced syntax highlighting, indentation, and incremental selection
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then return end
    
    configs.setup({
      ensure_installed = {
        "c", "cpp", "cmake", "make", "lua", "vim", "vimdoc", "query",
        "bash", "json", "yaml", "toml", "markdown", "markdown_inline",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
