-- NATIVE NEOVIM 0.11 LSP - Clean production version
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Configure clangd natively
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
    
    -- Configure neocmakelsp natively
    local mason_path = vim.fn.stdpath("data") .. "/mason/bin/neocmakelsp"
    if vim.fn.executable(mason_path) == 1 then
      vim.lsp.config['neocmakelsp'] = {
        cmd = { mason_path, "stdio" },
        filetypes = { "cmake" },
        root_markers = { "CMakeLists.txt", ".git" },
      }
    end
    
    -- Enable the servers
    vim.lsp.enable("clangd")
    vim.lsp.enable("neocmakelsp")
    
    -- LSP attach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}
