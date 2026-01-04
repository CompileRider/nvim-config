-------------------------------------------------------------------------------
-- Indent guides with rainbow colors
-- Visual indentation levels for better code readability
-------------------------------------------------------------------------------
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local hooks = require("ibl.hooks")

    -- Vibrant rainbow colors (Dracula-inspired)
    local rainbow = {
      { "RainbowRed",    "#ff5555" },
      { "RainbowYellow", "#f1fa8c" },
      { "RainbowBlue",   "#8be9fd" },
      { "RainbowOrange", "#ffb86c" },
      { "RainbowGreen",  "#50fa7b" },
      { "RainbowViolet", "#ff79c6" },
      { "RainbowCyan",   "#00ffff" },
    }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for _, c in ipairs(rainbow) do
        vim.api.nvim_set_hl(0, c[1], { fg = c[2] })
      end
    end)

    local hl_names = vim.tbl_map(function(c) return c[1] end, rainbow)

    require("ibl").setup({
      indent = { char = "│", highlight = hl_names },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = true,
        highlight = hl_names,
        include = {
          node_type = {
            c = { "compound_statement", "if_statement", "for_statement", "while_statement", "switch_statement", "function_definition", "struct_specifier" },
            lua = { "function", "if_statement", "for_statement", "while_statement", "table_constructor" },
          },
        },
      },
      exclude = { filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "toggleterm", "oil" } },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
