-- Spectre: Project-wide search and replace with beautiful UI
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sr", function() require("spectre").toggle() end, desc = "Search & Replace" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search word" },
  },
  opts = {
    open_cmd = "noswapfile vnew",
    live_update = true,
    highlight = {
      ui = "String",
      search = "DiffAdd",
      replace = "DiffDelete",
    },
    default = {
      find = { cmd = "rg", options = { "ignore-case" } },
      replace = { cmd = "sed" },
    },
  },
}
