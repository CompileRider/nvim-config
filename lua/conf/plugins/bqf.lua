-------------------------------------------------------------------------------
-- Better Quickfix window
-- Enhanced quickfix for navigating compilation errors
-------------------------------------------------------------------------------
return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    auto_enable = true,
    auto_resize_height = true,
    preview = { win_height = 12, delay_syntax = 80, border = "rounded", show_title = true },
    filter = { fzf = { action_for = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" } } },
  },
}
