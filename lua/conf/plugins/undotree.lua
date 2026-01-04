-- Undotree: Beautiful undo history visualization
return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_DiffpanelHeight = 12
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_TreeNodeShape = "◉"
    vim.g.undotree_TreeVertShape = "│"
    vim.g.undotree_TreeSplitShape = "╱"
    vim.g.undotree_TreeReturnShape = "╲"
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_HighlightChangedText = 1
    vim.g.undotree_HighlightChangedWithSign = 1
    vim.g.undotree_HelpLine = 0
  end,
}
