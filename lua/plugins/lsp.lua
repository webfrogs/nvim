-- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-- mason:
-- mason-lspconfig:
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
    },
    config = function()
      local kind_icons = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "󰈙 ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Operator = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = "󰬂 ",
        Value = " ",
        Variable = " ",
      }
      local source_names = {
        nvim_lsp = "(LSP)",
        emoji = "(Emoji)",
        path = "(Path)",
        calc = "(Calc)",
        cmp_tabnine = "(Tabnine)",
        vsnip = "(Snippet)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
        spell = "(Spell)",
      }
      local duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      }

      local cmp = require('cmp')
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = source_names[entry.source.name]
            vim_item.dup = duplicates[entry.source.name] or 0
            return vim_item
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = "treesitter" },
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(_, bufnr)
        local opts = { buffer = bufnr }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

        -- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        -- vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "gopls",
          "golangci_lint_ls",
          "clangd",
          -- "pylsp",
          "pyright",
          "ts_ls",
        },
        handlers = {
          function(server_name)
            local require_ok, lsp_custom_opts = pcall(require, "config.lsp." .. server_name)
            if require_ok then
              require('lspconfig')[server_name].setup(lsp_custom_opts)
            else
              require('lspconfig')[server_name].setup({})
            end
          end,
        }
      })
    end
  }
}
