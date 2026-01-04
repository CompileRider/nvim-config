-- Platform detection utilities
local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_mac = vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1
M.is_linux = vim.fn.has("unix") == 1 and not M.is_mac
M.is_wsl = vim.fn.has("wsl") == 1

-- Get OS name
M.os_name = (function()
  if M.is_windows then return "windows"
  elseif M.is_mac then return "macos"
  elseif M.is_wsl then return "wsl"
  elseif M.is_linux then return "linux"
  else return "unknown"
  end
end)()

-- Path separator
M.sep = M.is_windows and "\\" or "/"

-- Get appropriate shell
M.get_shell = function()
  if M.is_windows then
    if vim.fn.executable("pwsh") == 1 then return "pwsh"
    elseif vim.fn.executable("powershell") == 1 then return "powershell"
    else return "cmd.exe"
    end
  else
    return vim.o.shell or "/bin/sh"
  end
end

-- Check if command exists
M.has_cmd = function(cmd)
  return vim.fn.executable(cmd) == 1
end

return M
