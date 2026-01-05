-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              nvim-lint                                   ║
-- ║       Maximum static analysis for C/C++ with cppcheck + clang-tidy       ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- ┌──────────────────────────────────────────────────────────────────────┐
    -- │ CPPCHECK - Maximum detection mode                                    │
    -- │ Detects: memory leaks, null pointers, buffer overflows, dead code    │
    -- └──────────────────────────────────────────────────────────────────────┘
    lint.linters.cppcheck = {
      cmd = "cppcheck",
      stdin = false,
      args = {
        "--enable=all",              -- ALL checks: warning, style, performance, portability, information, unusedFunction
        "--inconclusive",            -- Report even uncertain issues (more false positives but catches more bugs)
        "--force",                   -- Check all #ifdef configurations
        "--inline-suppr",            -- Allow inline suppressions
        "--suppress=missingIncludeSystem",
        "--suppress=unmatchedSuppression",
        "--template={file}:{line}:{column}: [{severity}] {message} [{id}]",
      },
      stream = "stderr",
      ignore_exitcode = true,
      parser = require("lint.parser").from_pattern(
        "([^:]+):(%d+):(%d+): %[(%w+)%] (.+) %[(.+)%]",
        { "file", "lnum", "col", "severity", "message", "code" },
        {
          error = vim.diagnostic.severity.ERROR,
          warning = vim.diagnostic.severity.WARN,
          style = vim.diagnostic.severity.HINT,
          performance = vim.diagnostic.severity.INFO,
          portability = vim.diagnostic.severity.INFO,
          information = vim.diagnostic.severity.INFO,
        },
        { source = "cppcheck" }
      ),
    }

    -- ┌──────────────────────────────────────────────────────────────────────┐
    -- │ CLANG-TIDY - Deep static analysis                                    │
    -- │ Detects: memory leaks, use-after-free, null dereference, security    │
    -- └──────────────────────────────────────────────────────────────────────┘
    lint.linters.clangtidy = {
      cmd = "clang-tidy",
      stdin = false,
      args = {
        "--checks=" .. table.concat({
          "clang-analyzer-*",           -- Clang static analyzer (memory leaks, null ptr, etc)
          "bugprone-*",                 -- Bug-prone patterns
          "cert-*",                     -- CERT secure coding
          "performance-*",              -- Performance issues
          "portability-*",              -- Portability issues
          "security-*",                 -- Security vulnerabilities
          "misc-*",                     -- Miscellaneous checks
          "-clang-analyzer-osx.*",      -- Disable macOS-specific
          "-clang-analyzer-webkit.*",   -- Disable WebKit-specific
        }, ","),
        "--quiet",
      },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_pattern(
        "([^:]+):(%d+):(%d+): (%w+): (.+) %[(.+)%]",
        { "file", "lnum", "col", "severity", "message", "code" },
        {
          error = vim.diagnostic.severity.ERROR,
          warning = vim.diagnostic.severity.WARN,
          note = vim.diagnostic.severity.INFO,
        },
        { source = "clang-tidy" }
      ),
    }

    -- Linters by filetype
    lint.linters_by_ft = {
      c = { "cppcheck", "clangtidy" },
      cpp = { "cppcheck", "clangtidy" },
    }

    -- Lint triggers
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
      callback = function()
        local ft = vim.bo.filetype
        if ft == "c" or ft == "cpp" then
          lint.try_lint()
        end
      end,
    })

    -- Manual lint keymap
    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}
