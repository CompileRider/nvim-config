-- Lualine - Modern statusline
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "Civitasv/cmake-tools.nvim", -- For CMake integration
  },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    
    -- Custom CMake component
    local cmake_component = {
      function()
        local cmake_tools = package.loaded["cmake-tools"]
        if cmake_tools and cmake_tools.is_cmake_project() then
          local target = cmake_tools.get_build_target()
          local variant = cmake_tools.get_variant()
          if target and variant then
            return string.format("󰔷 %s [%s]", target, variant)
          elseif target then
            return string.format("󰔷 %s", target)
          else
            return "󰔷 CMake"
          end
        end
        return ""
      end,
      cond = function()
        return package.loaded["cmake-tools"] and require("cmake-tools").is_cmake_project()
      end,
      color = { fg = "#f7768e" },
    }
    
    -- LSP clients component
    local lsp_component = {
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return " " .. table.concat(client_names, ", ")
      end,
      color = { fg = "#7aa2f7" },
    }
    
    lualine.setup({
      options = {
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 
          "branch", 
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
          {
            "diagnostics",
            sources = { "nvim_lsp", "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1, -- Relative path
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = {
          cmake_component,
          lsp_component,
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "oil", "toggleterm", "aerial" },
    })
  end,
}
