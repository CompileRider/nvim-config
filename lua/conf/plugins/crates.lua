-- Cargo.toml dependency management
return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  config = function()
    local crates = require("crates")
    crates.setup({
      lsp = { enabled = true, actions = true, completion = true, hover = true },
      loading_indicator = false, -- Use fidget instead
    })

    -- Keymaps for Cargo.toml
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = "Cargo.toml",
      callback = function()
        local opts = { silent = true, buffer = true }
        vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
        vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
        vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
        vim.keymap.set("n", "<leader>cu", crates.upgrade_crate, opts)
        vim.keymap.set("n", "<leader>cU", crates.upgrade_all_crates, opts)
        vim.keymap.set("n", "<leader>ci", crates.show_crate_popup, opts)
        vim.keymap.set("n", "K", crates.show_crate_popup, opts)
      end,
    })
  end,
}
