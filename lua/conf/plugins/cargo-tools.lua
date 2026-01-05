-- Auto-install cargo tools on first run
local tools = { "bacon", "bacon-ls", "taplo-cli" }

local function check_and_install()
  local missing = {}
  for _, tool in ipairs(tools) do
    local bin = tool == "taplo-cli" and "taplo" or tool
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, tool)
    end
  end

  if #missing == 0 then return end

  if vim.fn.executable("cargo") == 0 then
    vim.notify("Cargo not found. Install Rust: https://rustup.rs", vim.log.levels.WARN)
    return
  end

  vim.notify("Installing cargo tools: " .. table.concat(missing, ", "), vim.log.levels.INFO)

  for _, tool in ipairs(missing) do
    vim.fn.jobstart({ "cargo", "install", tool, "--locked" }, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify(tool .. " installed", vim.log.levels.INFO)
        else
          vim.notify(tool .. " install failed", vim.log.levels.ERROR)
        end
      end,
    })
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.defer_fn(check_and_install, 1000)
  end,
})

return {}
