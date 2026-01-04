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
          "--style={"
            .. "BasedOnStyle: LLVM, "
            .. "IndentWidth: 8, "
            .. "TabWidth: 8, "
            .. "UseTab: Always, "
            .. "ColumnLimit: 80, "
            .. "BreakBeforeBraces: Linux, "
            .. "AllowShortFunctionsOnASingleLine: None, "
            .. "AllowShortIfStatementsOnASingleLine: false, "
            .. "AllowShortLoopsOnASingleLine: false, "
            .. "AllowShortBlocksOnASingleLine: false, "
            .. "IndentCaseLabels: false, "
            .. "IndentGotoLabels: false, "
            .. "PointerAlignment: Right, "
            .. "SpaceAfterCStyleCast: false, "
            .. "SpaceBeforeParens: ControlStatementsExceptForEachMacros, "
            .. "AlignAfterOpenBracket: Align, "
            .. "AlignTrailingComments: false, "
            .. "AlignConsecutiveAssignments: false, "
            .. "AlignConsecutiveDeclarations: false, "
            .. "AlignOperands: true, "
            .. "BinPackArguments: true, "
            .. "BinPackParameters: true, "
            .. "ContinuationIndentWidth: 8, "
            .. "ReflowComments: false, "
            .. "SortIncludes: false"
            .. "}",
        },
      },
    },
  },
}
