require "conf"

-- Disable treesitter in telescope previews (fixes ft_to_lang errors)
vim.schedule(function()
  local ok, telescope = pcall(require, "telescope")
  if ok then telescope.setup({ defaults = { preview = { treesitter = false } } }) end
end)

