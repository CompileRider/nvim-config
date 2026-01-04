-- Illuminate: Highlight word under cursor with smooth visuals
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = { "lsp", "treesitter", "regex" },
      delay = 80,
      filetypes_denylist = { "dashboard", "neo-tree", "TelescopePrompt", "toggleterm", "trouble" },
      under_cursor = true,
      large_file_cutoff = 2000,
      min_count_to_highlight = 2,
    })
    
    -- Beautiful highlight colors
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3b4261", underline = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3b4261", underline = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3b4261", underline = true, bold = true })
    
    vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(true) end, { desc = "Next reference" })
    vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(true) end, { desc = "Prev reference" })
  end,
}
