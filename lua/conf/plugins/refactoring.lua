return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "c", "cpp" },
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        c = true,
        cpp = true,
      },
      prompt_func_param_type = {
        c = true,
        cpp = true,
      },
      printf_statements = {
        c = { 'printf("%%s %%d\\n", "%s", %s);' },
        cpp = { 'std::cout << "%s " << %s << std::endl;' },
      },
      print_var_statements = {
        c = { 'printf("%%s %%d\\n", "%s", %s);' },
        cpp = { 'std::cout << "%s " << %s << std::endl;' },
      },
    })
  end,
}
