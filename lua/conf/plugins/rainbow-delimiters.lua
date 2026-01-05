-- Rainbow colored brackets and parentheses
return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufReadPost",
  config = function()
    local rainbow = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = { [""] = rainbow.strategy["global"], rust = rainbow.strategy["global"] },
      query = { [""] = "rainbow-delimiters", rust = "rainbow-delimiters" },
      highlight = { "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue", "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet", "RainbowDelimiterCyan" },
    }
  end,
}
