-- Auto-install cargo tools (asks once, sequential install)
local tools = { "bacon", "bacon-ls", "taplo-cli" }
local config_file = vim.fn.stdpath("data") .. "/cargo-tools-asked.txt"

local function was_asked()
  local f = io.open(config_file, "r")
  if f then f:close() return true end
  return false
end

local function mark_asked()
  local f = io.open(config_file, "w")
  if f then f:write("asked") f:close() end
end

local function get_missing()
  local missing = {}
  for _, tool in ipairs(tools) do
    local bin = tool == "taplo-cli" and "taplo" or tool
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, tool)
    end
  end
  return missing
end

local function install_sequential(list, idx)
  if idx > #list then
    vim.notify("All cargo tools installed", vim.log.levels.INFO)
    return
  end
  local tool = list[idx]
  vim.notify("Installing " .. tool .. " (" .. idx .. "/" .. #list .. ")...", vim.log.levels.INFO)
  vim.fn.jobstart({ "cargo", "install", tool, "--locked" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function() install_sequential(list, idx + 1) end)
      else
        vim.notify(tool .. " failed, stopping", vim.log.levels.ERROR)
      end
    end,
  })
end

local function prompt_install()
  local missing = get_missing()
  if #missing == 0 then return end

  if vim.fn.executable("cargo") == 0 then
    vim.notify("Cargo not found. Install Rust: https://rustup.rs", vim.log.levels.WARN)
    mark_asked()
    return
  end

  vim.ui.select({ "Yes", "No" }, {
    prompt = "Install cargo tools? (" .. table.concat(missing, ", ") .. ")",
  }, function(choice)
    mark_asked()
    if choice == "Yes" then
      install_sequential(missing, 1)
    end
  end)
end

-- Only ask once on first run
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if not was_asked() then
      vim.defer_fn(prompt_install, 1000)
    end
  end,
})

-- Command to manually trigger install prompt
vim.api.nvim_create_user_command("CargoTools", function()
  local missing = get_missing()
  if #missing == 0 then
    vim.notify("All cargo tools already installed", vim.log.levels.INFO)
  else
    prompt_install()
  end
end, {})

return {}
