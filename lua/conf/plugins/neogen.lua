-- Documentation generator (rustdoc for Rust)
return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
  keys = {
    { "<leader>ng", function() require("neogen").generate() end, desc = "Generate docs" },
    { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Function docs" },
    { "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Type docs" },
  },
  opts = {
    snippet_engine = "luasnip",
    languages = {
      rust = { template = { annotation_convention = "rustdoc" } },
      lua = { template = { annotation_convention = "emmylua" } },
    },
  },
}
