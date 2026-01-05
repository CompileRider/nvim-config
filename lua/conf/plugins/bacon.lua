-- Bacon diagnostics + Cargo commands with toggleterm integration
return {
  "Canop/nvim-bacon",
  ft = { "rust" },
  keys = {
    { "<leader>bb", "<cmd>BaconLoad<cr><cmd>BaconList<cr>", desc = "Bacon list" },
    { "<leader>bn", "<cmd>BaconNext<cr>", desc = "Bacon next" },
    { "<leader>bp", "<cmd>BaconPrevious<cr>", desc = "Bacon prev" },
  },
  config = function()
    require("bacon").setup({ quickfix = { enabled = true } })

    local function cargo(cmd)
      local ok, tt = pcall(require, "toggleterm.terminal")
      if ok then
        tt.Terminal:new({ cmd = "cargo " .. cmd, close_on_exit = false, direction = "float" }):toggle()
      else
        vim.cmd("!cargo " .. cmd)
      end
    end

    vim.keymap.set("n", "<leader>Cr", function() cargo("run") end, { desc = "Cargo run" })
    vim.keymap.set("n", "<leader>Cb", function() cargo("build") end, { desc = "Cargo build" })
    vim.keymap.set("n", "<leader>CB", function() cargo("build --release") end, { desc = "Cargo build release" })
    vim.keymap.set("n", "<leader>Ct", function() cargo("nextest run") end, { desc = "Cargo test" })
    vim.keymap.set("n", "<leader>Cc", function() cargo("clippy") end, { desc = "Cargo clippy" })
    vim.keymap.set("n", "<leader>Cd", function() cargo("doc --open") end, { desc = "Cargo doc" })
    vim.keymap.set("n", "<leader>Cf", function() cargo("fmt") end, { desc = "Cargo fmt" })
    vim.keymap.set("n", "<leader>Cu", function() cargo("update") end, { desc = "Cargo update" })
    vim.keymap.set("n", "<leader>Ca", function() cargo("add " .. vim.fn.input("Crate: ")) end, { desc = "Cargo add" })
  end,
}
