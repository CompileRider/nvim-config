-- Lualine - Rust statusline
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    -- LSP clients component
    local lsp_component = {
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then return "" end
        local names = {}
        for _, c in ipairs(clients) do table.insert(names, c.name) end
        return " " .. table.concat(names, ", ")
      end,
      color = { fg = "#7aa2f7" },
    }

    -- Rust/Cargo component
    local rust_component = {
      function()
        if vim.bo.filetype ~= "rust" then return "" end
        return "🦀 Rust"
      end,
      color = { fg = "#E45A28" },
    }

    require("lualine").setup({
      options = {
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
        },
        lualine_c = { { "filename", path = 1, symbols = { modified = "[+]", readonly = "[-]" } } },
        lualine_x = { rust_component, lsp_component, "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "oil", "toggleterm" },
    })
  end,
}
