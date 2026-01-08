-- Inline diagnostics: icon only, expand on cursor
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      transparent_bg = true,
      options = {
        show_source = { enabled = true },
        multilines = { enabled = true, always_show = false },
        show_all_diags_on_cursorline = true,
        overflow = { mode = "wrap" },
        throttle = 20,
        softwrap = 50,
        add_messages = {
          messages = false,           -- Hide messages by default
          display_count = false,      -- Just show icon
          show_multiple_glyphs = true,
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
