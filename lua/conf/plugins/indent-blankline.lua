-- Indent Blankline - Visual indent guides
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ibl = require("ibl")
    
    -- Define highlight groups
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    
    local hooks = require("ibl.hooks")
    -- Create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
    
    ibl.setup({
      indent = {
        char = "│",
        tab_char = "│",
        highlight = highlight,
        smart_indent_cap = true,
        priority = 2,
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = false,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
        include = {
          node_type = {
            ["*"] = { "return_statement", "table_constructor" },
            c = {
              "compound_statement",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "case_statement",
              "function_definition",
              "struct_specifier",
              "enum_specifier",
              "union_specifier",
            },
            cpp = {
              "compound_statement",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "case_statement",
              "function_definition",
              "struct_specifier",
              "class_specifier",
              "enum_specifier",
              "union_specifier",
              "namespace_definition",
              "template_declaration",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "oil",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    })
    
    -- Setup scope highlighting for C/C++
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
