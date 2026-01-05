-- Rust LSP: rustaceanvim + bacon-ls
return {
  -- rust-analyzer via rustaceanvim (handles LSP, DAP, and Rust-specific features)
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    init = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end

      vim.g.rustaceanvim = {
        tools = { hover_actions = { replace_builtin_hover = true } },
        server = {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
            vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, opts)
            vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("renderDiagnostic") end, opts)
            vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, opts)
            vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, opts)
            vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, opts)
            vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("rebuildProcMacros") end, opts)
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                allTargets = true,
                buildScripts = { enable = true },
                autoreload = true,
                cfgs = { "debug_assertions", "miri", "target_os=linux", "target_os=windows", "target_os=macos", "target_arch=x86_64", "target_arch=aarch64", "unix", "windows" },
              },
              procMacro = { enable = true, attributes = { enable = true } },
              checkOnSave = false,
              diagnostics = { enable = false },
              completion = {
                autoimport = { enable = true },
                autoself = { enable = true },
                callable = { snippets = "fill_arguments" },
                postfix = { enable = true },
                privateEditable = { enable = true },
                fullFunctionSignatures = { enable = true },
                termSearch = { enable = true, fuel = 1000 },
                autoAwait = { enable = true },
                autoIter = { enable = true },
              },
              inlayHints = {
                chainingHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 10 },
                lifetimeElisionHints = { enable = "always", useParameterNames = true },
                closureCaptureHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                discriminantHints = { enable = "always" },
                expressionAdjustmentHints = { enable = "always" },
                implicitDrops = { enable = true },
                rangeExclusiveHints = { enable = true },
                reborrowHints = { enable = "always" },
              },
              hover = {
                actions = { enable = true, debug = { enable = true }, run = { enable = true } },
                documentation = { enable = true, keywords = { enable = true } },
                links = { enable = true },
                memoryLayout = { enable = true },
              },
              lens = {
                enable = true,
                debug = { enable = true },
                implementations = { enable = true },
                references = { adt = { enable = true }, enumVariant = { enable = true }, method = { enable = true }, trait = { enable = true } },
                run = { enable = true },
              },
              semanticHighlighting = {
                operator = { specialization = { enable = true } },
                punctuation = { enable = true, specialization = { enable = true } },
              },
              imports = { granularity = { group = "module" }, prefix = "self" },
              assist = { emitMustUse = true, expressionFillDefault = "default" },
            },
          },
        },
        dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(
            vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
          ),
        },
      }
    end,
  },
  -- bacon-ls: Fast background diagnostics
  {
    "neovim/nvim-lspconfig",
    ft = { "rust", "toml" },
    config = function()
      -- bacon-ls for Rust
      vim.lsp.config["bacon_ls"] = {
        cmd = { vim.fn.expand("~/.cargo/bin/bacon-ls") },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        init_options = { updateOnSave = true, updateOnSaveWaitMillis = 500 },
      }
      vim.lsp.enable("bacon_ls")

      -- taplo for TOML (Cargo.toml completion, validation, formatting)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end

      vim.lsp.config["taplo"] = {
        cmd = { vim.fn.expand("~/.cargo/bin/taplo"), "lsp", "stdio" },
        filetypes = { "toml" },
        root_markers = { ".git", "Cargo.toml", ".taplo.toml", "taplo.toml" },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        end,
        init_options = {
          configurationSection = "evenBetterToml",
          cachePath = vim.fn.stdpath("cache") .. "/taplo",
        },
        settings = {
          evenBetterToml = {
            schema = {
              enabled = true,
              catalogs = { "https://www.schemastore.org/api/json/catalog.json" },
            },
            formatter = {
              alignEntries = false,
              alignComments = true,
              arrayTrailingComma = true,
              arrayAutoExpand = true,
              arrayAutoCollapse = true,
              compactArrays = true,
              compactInlineTables = false,
              columnWidth = 100,
              indentString = "  ",
              trailingNewline = true,
              reorderKeys = false,
              allowedBlankLines = 1,
            },
          },
        },
      }
      vim.lsp.enable("taplo")
    end,
  },
}
