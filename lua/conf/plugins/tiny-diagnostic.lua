-- Inline diagnostics with modern styling
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      transparent_bg = true,
      options = {
        multilines = { enabled = true },
        show_source = { enabled = true },
        show_all_diags_on_cursorline = true,
        overflow = { mode = "wrap" },
        throttle = 50,
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
