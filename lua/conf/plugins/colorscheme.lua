-- Colorscheme collection with live preview
-- Use :Colorscheme to pick a theme (previews as you navigate, persists on Enter)

local config_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

local function get_saved()
  local f = io.open(config_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    return name
  end
  return "tokyonight"
end

local function save(name)
  local f = io.open(config_file, "w")
  if f then f:write(name) f:close() end
end

-- Rust semantic highlights
local function apply_rust_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "@lsp.type.lifetime.rust", { fg = "#bb9af7", italic = true })
  hl(0, "@lsp.type.selfKeyword.rust", { fg = "#f7768e", bold = true })
  hl(0, "@lsp.mod.mutable.rust", { underline = true })
  hl(0, "@lsp.mod.unsafe.rust", { fg = "#f7768e", bold = true })
  hl(0, "RainbowDelimiterRed", { fg = "#ff5555" })
  hl(0, "RainbowDelimiterYellow", { fg = "#f1fa8c" })
  hl(0, "RainbowDelimiterBlue", { fg = "#8be9fd" })
  hl(0, "RainbowDelimiterOrange", { fg = "#ffb86c" })
  hl(0, "RainbowDelimiterGreen", { fg = "#50fa7b" })
  hl(0, "RainbowDelimiterViolet", { fg = "#ff79c6" })
end

local themes = {
  tokyonight = { "folke/tokyonight.nvim", cmd = "tokyonight" },
  catppuccin = { "catppuccin/nvim", name = "catppuccin", cmd = "catppuccin-mocha" },
  rose_pine = { "rose-pine/neovim", name = "rose-pine", cmd = "rose-pine" },
  kanagawa = { "rebelot/kanagawa.nvim", cmd = "kanagawa" },
  gruvbox = { "ellisonleao/gruvbox.nvim", cmd = "gruvbox" },
  nord = { "shaunsingh/nord.nvim", cmd = "nord" },
  onedark = { "navarasu/onedark.nvim", cmd = "onedark" },
  nightfox = { "EdenEast/nightfox.nvim", cmd = "nightfox" },
  dracula = { "Mofiqul/dracula.nvim", cmd = "dracula" },
  embark = { "embark-theme/vim", name = "embark", cmd = "embark" },
  everforest = { "sainnhe/everforest", cmd = "everforest" },
  solarized = { "maxmx03/solarized.nvim", cmd = "solarized" },
  material = { "marko-cerovac/material.nvim", cmd = "material" },
  github_dark = { "projekt0n/github-nvim-theme", cmd = "github_dark" },
  oxocarbon = { "nyoom-engineering/oxocarbon.nvim", cmd = "oxocarbon" },
  dawnfox = { "EdenEast/nightfox.nvim", cmd = "dawnfox" },
  dayfox = { "EdenEast/nightfox.nvim", cmd = "dayfox" },
  duskfox = { "EdenEast/nightfox.nvim", cmd = "duskfox" },
  nordfox = { "EdenEast/nightfox.nvim", cmd = "nordfox" },
  terafox = { "EdenEast/nightfox.nvim", cmd = "terafox" },
  carbonfox = { "EdenEast/nightfox.nvim", cmd = "carbonfox" },
  catppuccin_latte = { "catppuccin/nvim", name = "catppuccin", cmd = "catppuccin-latte" },
  catppuccin_frappe = { "catppuccin/nvim", name = "catppuccin", cmd = "catppuccin-frappe" },
  catppuccin_macchiato = { "catppuccin/nvim", name = "catppuccin", cmd = "catppuccin-macchiato" },
  tokyonight_storm = { "folke/tokyonight.nvim", cmd = "tokyonight-storm" },
  tokyonight_day = { "folke/tokyonight.nvim", cmd = "tokyonight-day" },
  tokyonight_moon = { "folke/tokyonight.nvim", cmd = "tokyonight-moon" },
  rose_pine_moon = { "rose-pine/neovim", name = "rose-pine", cmd = "rose-pine-moon" },
  rose_pine_dawn = { "rose-pine/neovim", name = "rose-pine", cmd = "rose-pine-dawn" },
  github_dark_dimmed = { "projekt0n/github-nvim-theme", cmd = "github_dark_dimmed" },
  github_light = { "projekt0n/github-nvim-theme", cmd = "github_light" },
  kanagawa_wave = { "rebelot/kanagawa.nvim", cmd = "kanagawa-wave" },
  kanagawa_dragon = { "rebelot/kanagawa.nvim", cmd = "kanagawa-dragon" },
  kanagawa_lotus = { "rebelot/kanagawa.nvim", cmd = "kanagawa-lotus" },
  gruvbox_material = { "sainnhe/gruvbox-material", cmd = "gruvbox-material" },
  sonokai = { "sainnhe/sonokai", cmd = "sonokai" },
  edge = { "sainnhe/edge", cmd = "edge" },
  ayu = { "Shatur/neovim-ayu", cmd = "ayu" },
  moonfly = { "bluz71/vim-moonfly-colors", name = "moonfly", cmd = "moonfly" },
  nightfly = { "bluz71/vim-nightfly-colors", name = "nightfly", cmd = "nightfly" },
  tokyodark = { "tiagovla/tokyodark.nvim", cmd = "tokyodark" },
  cyberdream = { "scottmckendry/cyberdream.nvim", cmd = "cyberdream" },
  fluoromachine = { "maxmx03/fluoromachine.nvim", cmd = "fluoromachine" },
  monokai_pro = { "loctvl842/monokai-pro.nvim", cmd = "monokai-pro" },
  nightowl = { "oxfist/night-owl.nvim", cmd = "night-owl" },
  poimandres = { "olivercederborg/poimandres.nvim", cmd = "poimandres" },
  melange = { "savq/melange-nvim", cmd = "melange" },
  zenbones = { "zenbones-theme/zenbones.nvim", cmd = "zenbones" },
  zenburned = { "zenbones-theme/zenbones.nvim", cmd = "zenburned" },
  neobones = { "zenbones-theme/zenbones.nvim", cmd = "neobones" },
  vimbones = { "zenbones-theme/zenbones.nvim", cmd = "vimbones" },
  rosebones = { "zenbones-theme/zenbones.nvim", cmd = "rosebones" },
  forestbones = { "zenbones-theme/zenbones.nvim", cmd = "forestbones" },
  nordbones = { "zenbones-theme/zenbones.nvim", cmd = "nordbones" },
  tokyobones = { "zenbones-theme/zenbones.nvim", cmd = "tokyobones" },
  seoulbones = { "zenbones-theme/zenbones.nvim", cmd = "seoulbones" },
  duckbones = { "zenbones-theme/zenbones.nvim", cmd = "duckbones" },
  kanagawabones = { "zenbones-theme/zenbones.nvim", cmd = "kanagawabones" },
  modus = { "miikanissi/modus-themes.nvim", cmd = "modus" },
  nordic = { "AlexvZyl/nordic.nvim", cmd = "nordic" },
  onedarkpro = { "olimorris/onedarkpro.nvim", cmd = "onedark" },
  vscode = { "Mofiqul/vscode.nvim", cmd = "vscode" },
  bamboo = { "ribru17/bamboo.nvim", cmd = "bamboo" },
  lackluster = { "slugbyte/lackluster.nvim", cmd = "lackluster" },
  eldritch = { "eldritch-theme/eldritch.nvim", cmd = "eldritch" },
  flow = { "0xstepit/flow.nvim", cmd = "flow" },
  bluloco = { "uloco/bluloco.nvim", cmd = "bluloco" },
  sweetie = { "NTBBloodbath/sweetie.nvim", cmd = "sweetie" },
  miasma = { "xero/miasma.nvim", cmd = "miasma" },
  iceberg = { "cocopon/iceberg.vim", cmd = "iceberg" },
  palenight = { "drewtempelmeyer/palenight.vim", cmd = "palenight" },
  spaceduck = { "pineapplegiant/spaceduck", cmd = "spaceduck" },
  horizon = { "lunarvim/horizon.nvim", cmd = "horizon" },
  doom_one = { "NTBBloodbath/doom-one.nvim", cmd = "doom-one" },
  aquarium = { "FrenzyExists/aquarium-vim", cmd = "aquarium" },
  substrata = { "kvrohit/substrata.nvim", cmd = "substrata" },
  rasmus = { "kvrohit/rasmus.nvim", cmd = "rasmus" },
  mellow = { "mellow-theme/mellow.nvim", cmd = "mellow" },
  minimal = { "Yazeed1s/minimal.nvim", cmd = "minimal" },
  oh_lucy = { "Yazeed1s/oh-lucy.nvim", cmd = "oh-lucy" },
}

-- Get unique repos from themes
local function get_repo(name)
  return themes[name] and themes[name][1]
end

local function apply_theme(name, silent)
  if not themes[name] then return end
  local repo = get_repo(name)
  local plugin_name = themes[name].name or repo:match("[^/]+$")
  
  if silent then
    local notify = vim.notify
    vim.notify = function() end
    pcall(function() require("lazy").load({ plugins = { plugin_name } }) end)
    pcall(vim.cmd.colorscheme, themes[name].cmd)
    vim.notify = notify
  else
    pcall(function() require("lazy").load({ plugins = { plugin_name } }) end)
    pcall(vim.cmd.colorscheme, themes[name].cmd)
  end
  apply_rust_highlights()
end

local selected = get_saved()
local selected_theme = themes[selected] or themes.tokyonight
local selected_repo = selected_theme[1]

-- Only install the selected theme's repo + repos needed for picker preview
local installed_repos = {}
local specs = {}

-- Add selected theme
installed_repos[selected_repo] = true
table.insert(specs, {
  selected_repo,
  name = selected_theme.name,
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme(selected_theme.cmd)
    apply_rust_highlights()
  end,
})

-- Picker command - installs themes on-demand
vim.api.nvim_create_user_command("Colorscheme", function()
  local names = vim.tbl_keys(themes)
  table.sort(names)
  local original = get_saved()

  require("telescope.pickers").new({}, {
    prompt_title = "Colorscheme (Enter to save, Esc to cancel)",
    finder = require("telescope.finders").new_table({ results = names }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(buf, map)
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")

      local function preview()
        local entry = state.get_selected_entry()
        if not entry then return end
        local name = entry[1]
        local repo = get_repo(name)
        
        -- Install if not installed
        if not installed_repos[repo] then
          local notify = vim.notify
          vim.notify = function() end
          pcall(function()
            require("lazy").install({ plugins = { repo }, wait = true })
            require("lazy").load({ plugins = { repo:match("[^/]+$") } })
          end)
          vim.notify = notify
          installed_repos[repo] = true
        end
        
        apply_theme(name, true)
      end

      map("i", "<Down>", function(b) actions.move_selection_next(b) preview() end)
      map("i", "<Up>", function(b) actions.move_selection_previous(b) preview() end)
      map("n", "j", function(b) actions.move_selection_next(b) preview() end)
      map("n", "k", function(b) actions.move_selection_previous(b) preview() end)

      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(buf)
        if entry then
          save(entry[1])
          apply_theme(entry[1])
          vim.notify("Colorscheme saved: " .. entry[1])
        end
      end)

      actions.close:enhance({ post = function()
        apply_theme(original, true)
      end })

      return true
    end,
  }):find()
end, {})

return specs
