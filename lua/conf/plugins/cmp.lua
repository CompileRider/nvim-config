-- Improved path completion for cmp
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
    'onsails/lspkind.nvim', -- VS Code-like pictograms
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      -- Enhanced window configuration with Apple-style borders
      window = {
        completion = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
          scrollbar = false,
        }),
        documentation = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:CmpDoc',
        }),
      },
      
      -- Professional formatting with icons
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function(entry, vim_item)
            -- Enhanced path completion display
            if entry.source.name == 'path' then
              vim_item.kind = '📁 Path'
              -- Show relative path for better readability
              local path = vim_item.word
              if path:match('^/') then
                local cwd = vim.fn.getcwd()
                if path:find(cwd, 1, true) == 1 then
                  vim_item.word = './' .. path:sub(#cwd + 2)
                end
              end
            end
            return vim_item
          end,
        }),
      },
      
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ 
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      
      -- Enhanced sources with priority
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'nvim_lsp_signature_help', priority = 1000 },
        { name = 'luasnip', priority = 750 },
        { name = 'nvim_lua', priority = 500 },
      }, {
        { 
          name = 'path',
          priority = 250,
          option = {
            -- Enhanced path completion options
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(params)
              return vim.fn.expand(('#%d:p:h'):format(params.context.bufnr))
            end,
          },
        },
        { name = 'buffer', priority = 250, keyword_length = 3 },
      }),
      
      -- Performance optimizations
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 200,
      },
      
      -- Enhanced matching
      matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
      },
    })

    -- Enhanced cmdline completion with path support
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { 
          name = 'path',
          option = {
            trailing_slash = true,
            label_trailing_slash = true,
          },
        }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
  end,
}
