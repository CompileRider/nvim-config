-- Cargo.toml dependency management with animated loading spinner
return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  config = function()
    local crates = require("crates")
    crates.setup({
      lsp = { enabled = true, actions = true, completion = true, hover = true },
      loading_indicator = false,
    })

    -- Animated spinner (monkeypatch crates.nvim UI)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local ns = vim.api.nvim_create_namespace("crates_spinner")
    local timer, frame = nil, 1
    local loading_lines = {}

    local function animate()
      frame = frame % #spinner + 1
      for buf, lines in pairs(loading_lines) do
        if vim.api.nvim_buf_is_valid(buf) and #lines > 0 then
          vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
          for _, line in ipairs(lines) do
            pcall(vim.api.nvim_buf_set_extmark, buf, ns, line, 0, {
              virt_text = { { " " .. spinner[frame] .. " Loading", "CratesNvimLoading" } },
              virt_text_pos = "eol",
              priority = 200,
            })
          end
        end
      end
    end

    local function start_animation()
      if not timer then
        timer = vim.uv.new_timer()
        timer:start(0, 80, vim.schedule_wrap(animate))
      end
    end

    local function stop_animation(buf)
      loading_lines[buf] = nil
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      end
      if vim.tbl_isempty(loading_lines) and timer then
        timer:stop()
        timer:close()
        timer = nil
      end
    end

    vim.defer_fn(function()
      local ok, ui = pcall(require, "crates.ui")
      if not ok then return end
      
      local orig_display_crate_info = ui.display_crate_info

      ui.display_loading = function(buf, crates_list)
        loading_lines[buf] = {}
        for _, crate in ipairs(crates_list) do
          table.insert(loading_lines[buf], crate.lines and crate.lines.s or 0)
        end
        if #loading_lines[buf] > 0 then start_animation() end
      end

      ui.display_crate_info = function(buf, infos)
        stop_animation(buf)
        orig_display_crate_info(buf, infos)
      end
    end, 100)

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
