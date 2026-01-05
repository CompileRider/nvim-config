-- Auto-install Rust tools (asks once, sequential install)
local cargo_tools = { "bacon", "bacon-ls", "taplo-cli", "sccache" }
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

local function get_missing_cargo()
  local missing = {}
  for _, tool in ipairs(cargo_tools) do
    local bin = tool == "taplo-cli" and "taplo" or tool
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, tool)
    end
  end
  return missing
end

local function has_rust_analyzer()
  return vim.fn.executable("rust-analyzer") == 1
end

local function install_sequential(list, idx, callback)
  if idx > #list then
    if callback then callback() end
    return
  end
  local tool = list[idx]
  vim.notify("Installing " .. tool .. " (" .. idx .. "/" .. #list .. ")...", vim.log.levels.INFO)
  vim.fn.jobstart({ "cargo", "install", tool, "--locked" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function() install_sequential(list, idx + 1, callback) end)
      else
        vim.notify(tool .. " failed", vim.log.levels.ERROR)
      end
    end,
  })
end

local function setup_sccache()
  local cargo_home = vim.fn.expand("$CARGO_HOME")
  if cargo_home == "" or cargo_home == "$CARGO_HOME" then
    cargo_home = vim.fn.expand("~/.cargo")
  end
  local config_path = cargo_home .. "/config.toml"
  
  -- Check if sccache is already configured
  local f = io.open(config_path, "r")
  if f then
    local content = f:read("*a")
    f:close()
    if content:find("sccache") then return end
  end
  
  -- Append sccache config
  local sccache_path = cargo_home .. "/bin/sccache"
  if vim.fn.has("win32") == 1 then
    sccache_path = sccache_path .. ".exe"
  end
  
  f = io.open(config_path, "a")
  if f then
    f:write("\n# Auto-configured by nvim\n")
    f:write("[build]\n")
    f:write('rustc-wrapper = "' .. sccache_path .. '"\n')
    f:close()
    vim.notify("sccache configured in " .. config_path, vim.log.levels.INFO)
  end
end

local function install_rust_analyzer()
  vim.notify("Installing rust-analyzer via rustup...", vim.log.levels.INFO)
  vim.fn.jobstart({ "rustup", "component", "add", "rust-analyzer" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("rust-analyzer installed", vim.log.levels.INFO)
      else
        vim.notify("rust-analyzer install failed (try: rustup component add rust-analyzer)", vim.log.levels.ERROR)
      end
    end,
  })
end

local function prompt_install()
  local missing_cargo = get_missing_cargo()
  local missing_ra = not has_rust_analyzer()
  
  if #missing_cargo == 0 and not missing_ra then return end

  if vim.fn.executable("cargo") == 0 then
    vim.notify("Cargo not found. Install Rust: https://rustup.rs", vim.log.levels.WARN)
    mark_asked()
    return
  end

  local msg = "Install Rust tools?"
  if #missing_cargo > 0 then
    msg = msg .. "\nCargo: " .. table.concat(missing_cargo, ", ")
  end
  if missing_ra then
    msg = msg .. "\nrustup: rust-analyzer"
  end

  vim.ui.select({ "Yes", "No" }, { prompt = msg }, function(choice)
    mark_asked()
    if choice == "Yes" then
      if missing_ra then install_rust_analyzer() end
      if #missing_cargo > 0 then
        install_sequential(missing_cargo, 1, function()
          if vim.tbl_contains(missing_cargo, "sccache") then
            setup_sccache()
          end
          vim.notify("All Rust tools installed", vim.log.levels.INFO)
        end)
      end
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
  local missing_cargo = get_missing_cargo()
  local missing_ra = not has_rust_analyzer()
  if #missing_cargo == 0 and not missing_ra then
    vim.notify("All Rust tools installed", vim.log.levels.INFO)
  else
    prompt_install()
  end
end, {})

return {}
