-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                            project.nvim                                  ║
-- ║         Auto-change cwd to project root (CMakeLists.txt, .git, etc)      ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  "DrKJeff16/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project").setup({
      -- Detection patterns (order matters)
      patterns = {
        "CMakeLists.txt",  -- CMake projects
        "Makefile",        -- Make projects
        "Cargo.toml",      -- Rust projects
        "package.json",    -- Node projects
        ".git",            -- Git repos
        ".gitignore",
      },
      -- Auto-change cwd when entering buffer
      manual_mode = false,
      -- Don't print messages when changing directory
      silent_chdir = true,
      -- Change cwd globally (not per tab/window)
      scope_chdir = "global",
    })

    -- Telescope integration
    pcall(function()
      require("telescope").load_extension("projects")
    end)

    -- Keymap to list recent projects
    vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Recent projects" })
  end,
}
