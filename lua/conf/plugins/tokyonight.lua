-- Tokyonight colorscheme with Rust semantic highlighting
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_highlights = function(hl, c)
        -- Inlay hints
        hl.LspInlayHint = { fg = "#565f89", bg = "NONE", italic = true }

        -- Rust semantic tokens
        hl["@lsp.type.lifetime.rust"] = { fg = "#bb9af7", italic = true }
        hl["@lsp.type.selfKeyword.rust"] = { fg = "#f7768e", bold = true }
        hl["@lsp.type.selfTypeKeyword.rust"] = { fg = "#f7768e", bold = true }
        hl["@lsp.type.decorator.rust"] = { fg = "#e0af68" }
        hl["@lsp.type.deriveHelper.rust"] = { fg = "#e0af68" }
        hl["@lsp.type.macro.rust"] = { fg = "#7dcfff", bold = true }
        hl["@lsp.type.attributeBracket.rust"] = { fg = "#e0af68" }
        hl["@lsp.type.builtinAttribute.rust"] = { fg = "#e0af68" }
        hl["@lsp.type.generic.rust"] = { fg = "#bb9af7" }
        hl["@lsp.type.formatSpecifier.rust"] = { fg = "#7dcfff" }
        hl["@lsp.type.escapeSequence.rust"] = { fg = "#7dcfff" }
        hl["@lsp.type.operator.rust"] = { fg = "#89ddff" }
        hl["@lsp.mod.mutable.rust"] = { underline = true }
        hl["@lsp.mod.consuming.rust"] = { bold = true }
        hl["@lsp.mod.async.rust"] = { italic = true }
        hl["@lsp.mod.reference.rust"] = { italic = true }
        hl["@lsp.typemod.function.unsafe.rust"] = { fg = "#f7768e", bold = true }
        hl["@lsp.typemod.keyword.unsafe.rust"] = { fg = "#f7768e", bold = true }

        -- Rainbow delimiters
        hl.RainbowDelimiterRed = { fg = "#ff5555" }
        hl.RainbowDelimiterYellow = { fg = "#f1fa8c" }
        hl.RainbowDelimiterBlue = { fg = "#8be9fd" }
        hl.RainbowDelimiterOrange = { fg = "#ffb86c" }
        hl.RainbowDelimiterGreen = { fg = "#50fa7b" }
        hl.RainbowDelimiterViolet = { fg = "#ff79c6" }
        hl.RainbowDelimiterCyan = { fg = "#00ffff" }

        -- Crates.nvim
        hl.CratesNvimVersion = { fg = "#9ece6a" }
        hl.CratesNvimUpgrade = { fg = "#e0af68" }
        hl.CratesNvimYanked = { fg = "#f7768e" }
        hl.CratesNvimPreRelease = { fg = "#bb9af7" }
        hl.CratesNvimNoMatch = { fg = "#f7768e" }
        hl.CratesNvimLoading = { fg = "#7aa2f7" }
        hl.CratesNvimPopupTitle = { fg = "#7aa2f7", bold = true }
        hl.CratesNvimPopupVersion = { fg = "#9ece6a" }
        hl.CratesNvimPopupFeature = { fg = "#7dcfff" }
        hl.CratesNvimPopupEnabled = { fg = "#9ece6a" }
        hl.CratesNvimPopupTransitive = { fg = "#565f89" }
      end,
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}
