-- Code formatting: rustfmt + taplo
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt" },
      toml = { "taplo" },
    },
    format_on_save = { timeout_ms = 1000, lsp_fallback = true },
  },
}
