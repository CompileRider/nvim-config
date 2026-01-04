-- Smooth animations for cursor, scroll, and window transitions
return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  config = function()
    local animate = require("mini.animate")
    animate.setup({
      cursor = { enable = true, timing = animate.gen_timing.linear({ duration = 100, unit = "total" }), path = animate.gen_path.line() },
      scroll = { enable = true, timing = animate.gen_timing.linear({ duration = 150, unit = "total" }), subscroll = animate.gen_subscroll.equal({ predicate = function(total_scroll) return total_scroll > 1 end }) },
      resize = { enable = true, timing = animate.gen_timing.linear({ duration = 100, unit = "total" }) },
      open = { enable = true, timing = animate.gen_timing.linear({ duration = 200, unit = "total" }), winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }), winblend = animate.gen_winblend.linear({ from = 80, to = 0 }) },
      close = { enable = true, timing = animate.gen_timing.linear({ duration = 150, unit = "total" }), winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }), winblend = animate.gen_winblend.linear({ from = 0, to = 80 }) },
    })
  end,
}
