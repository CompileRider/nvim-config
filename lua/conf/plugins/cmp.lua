-- Beautiful nvim-cmp with VS Code style icons
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- Beautiful highlight groups
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#808080', strikethrough = true })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#569CD6', bold = true })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#569CD6', bold = true })
    vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', italic = true })
    vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
    -- Crates.nvim custom kinds
    vim.api.nvim_set_hl(0, 'CmpItemKindVersion', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFeature', { fg = '#C3E88D', bg = '#9FBD73' })

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
          col_offset = -3,
          side_padding = 0,
        }),
        documentation = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu',
        }),
      },
      -- VS Code style: icon on left, text, then source
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          kind.kind = ' ' .. (strings[1] or '') .. ' '
          kind.menu = '    (' .. (strings[2] or '') .. ')'
          -- Crates.nvim
          if vim_item.kind == 'Version' then kind.kind = '  ' end
          if vim_item.kind == 'Feature' then kind.kind = '  ' end
          return kind
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
          else fallback() end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then luasnip.jump(-1)
          else fallback() end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'nvim_lsp_signature_help', priority = 900 },
        { name = 'crates', priority = 850 },
        { name = 'luasnip', priority = 750 },
        { name = 'nvim_lua', priority = 500 },
      }, {
        { name = 'path', priority = 250 },
        { name = 'buffer', priority = 250, keyword_length = 3 },
      }),
      experimental = { ghost_text = { hl_group = 'Comment' } },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
  end,
}
