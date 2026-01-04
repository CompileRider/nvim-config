-- LSP signature help plugin for better function parameter assistance
return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  config = function()
    require("lsp_signature").setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      },
      floating_window = true, -- show hint in a floating window, set to false for virtual text only
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
      
      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
      
      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
      
      padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
      
      transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
      
      select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
    })
  end,
}
