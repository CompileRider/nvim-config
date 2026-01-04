-- Notify: Beautiful animated notifications
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")
    notify.setup({
      -- Animation
      stages = "fade_in_slide_out",
      fps = 60,
      timeout = 3000,
      
      -- Appearance
      render = "wrapped-compact",
      max_width = 50,
      max_height = 10,
      minimum_width = 30,
      top_down = true,
      
      -- Icons
      icons = {
        ERROR = " ",
        WARN  = " ",
        INFO  = " ",
        DEBUG = " ",
        TRACE = " ",
      },
      
      -- Colors (uses theme colors)
      background_colour = "#000000",
      
      -- Behavior
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    })
    
    vim.notify = notify
  end,
}
