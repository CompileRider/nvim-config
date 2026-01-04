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
          "--style={BasedOnStyle: LLVM, IndentWidth: 8, TabWidth: 8, UseTab: Always, BreakBeforeBraces: Linux, AllowShortFunctionsOnASingleLine: None, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 80, PointerAlignment: Right, SpaceAfterCStyleCast: true, AlignAfterOpenBracket: DontAlign, AlignOperands: DontAlign, AlignTrailingComments: false, AllowAllParametersOfDeclarationOnNextLine: false, BinPackParameters: true, BinPackArguments: true}",
        },
      },
    },
  },
}
