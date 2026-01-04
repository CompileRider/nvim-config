-- NATIVE NEOVIM 0.11 LSP - Cross-platform (Linux/macOS/Windows)
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
    local sep = is_windows and "\\" or "/"
    
    -- Configure clangd (works on all platforms if installed)
    if vim.fn.executable("clangd") == 1 then
      vim.lsp.config['clangd'] = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--all-scopes-completion",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { "compile_commands.json", ".clangd", ".git" },
      }
      vim.lsp.enable("clangd")
    end
    
    -- Configure neocmakelsp (cross-platform mason path)
    local mason_bin = vim.fn.stdpath("data") .. sep .. "mason" .. sep .. "bin" .. sep
    local neocmakelsp = mason_bin .. (is_windows and "neocmakelsp.cmd" or "neocmakelsp")
    if vim.fn.executable(neocmakelsp) == 1 then
      vim.lsp.config['neocmakelsp'] = {
        cmd = { neocmakelsp, "stdio" },
        filetypes = { "cmake" },
        root_markers = { "CMakeLists.txt", ".git" },
      }
      vim.lsp.enable("neocmakelsp")
    end
    
    -- LSP attach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
      end,
    })
  end,
}
