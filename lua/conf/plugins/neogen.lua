-- Neogen: Beautiful documentation generator
return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
  keys = {
    { "<leader>ng", function() require("neogen").generate() end, desc = "Generate docs" },
    { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Func docs" },
    { "<leader>nc", function() require("neogen").generate({ type = "class" }) end, desc = "Class docs" },
    { "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Type docs" },
  },
  opts = {
    enabled = true,
    snippet_engine = "luasnip",
    input_after_comment = true,
    languages = {
      c = { template = { annotation_convention = "doxygen" } },
      cpp = { template = { annotation_convention = "doxygen" } },
      lua = { template = { annotation_convention = "emmylua" } },
    },
    placeholders_text = {
      ["description"] = "[TODO: description]",
      ["tparam"] = "[TODO: param description]",
      ["return"] = "[TODO: return description]",
    },
  },
}
