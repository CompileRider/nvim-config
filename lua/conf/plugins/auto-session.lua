-- Auto-session for session management
return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    
    auto_session.setup({
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_session_use_git_branch = false,
      
      -- Session lens configuration
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })
    
    -- Safe keymap for session-lens
    local ok, session_lens = pcall(require, "auto-session.session-lens")
    if ok then
      vim.keymap.set("n", "<C-s>", session_lens.search_session, { noremap = true })
    end
  end,
}
