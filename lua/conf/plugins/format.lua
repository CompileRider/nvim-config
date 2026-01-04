return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      clang_format = {
        prepend_args = {
          "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, BreakBeforeBraces: Allman, AllowShortFunctionsOnASingleLine: None, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: true, ColumnLimit: 100, PointerAlignment: Right, SpaceAfterCStyleCast: true}",
        },
      },
    },
  },
}
