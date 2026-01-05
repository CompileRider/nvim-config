-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                           Diffview.nvim                                  ║
-- ║         Beautiful git diff viewer with merge conflict resolution         ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
    { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diff vs last commit" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
  },
  opts = {
    diff_binaries = false,
    enhanced_diff_hl = true, -- Better diff highlighting
    use_icons = true,
    show_help_hints = true,
    watch_index = true,

    icons = {
      folder_closed = "",
      folder_open = "",
    },

    signs = {
      fold_closed = "",
      fold_open = "",
      done = "✓",
    },

    view = {
      default = {
        layout = "diff2_horizontal",
        disable_diagnostics = false,
        winbar_info = false,
      },
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        layout = "diff2_horizontal",
        disable_diagnostics = false,
        winbar_info = false,
      },
    },

    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
      },
    },

    file_history_panel = {
      log_options = {
        git = {
          single_file = { diff_merges = "combined" },
          multi_file = { diff_merges = "first-parent" },
        },
      },
      win_config = {
        position = "bottom",
        height = 16,
      },
    },

    hooks = {
      diff_buf_read = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.relativenumber = false
      end,
    },
  },

  config = function(_, opts)
    require("diffview").setup(opts)

    -- Catppuccin-inspired diff highlights
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#31262e" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = "#45475a" })
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1e3a2f" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2a2a3a" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a1e2e" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#3a3a5a" })
  end,
}
