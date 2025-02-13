return {
  {
    -- mason: https://github.com/williamboman/mason.nvim
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Autocompletion
  {
    -- blink: https://github.com/Saghen/blink.cmp
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        cmdline = {
          preset = 'default',
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lazydev", 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { "sources.default" }
  },


  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      -- mason-lspconfig: https://github.com/williamboman/mason-lspconfig.nvim
      { 'williamboman/mason-lspconfig.nvim' },
      { 'saghen/blink.cmp' },
    },
    config = function()
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
            local lspOpts = {}
            lspOpts.on_attach = lsp_attach
            local require_ok, lsp_custom_opts = pcall(require, "config.lsp." .. server_name)
            if require_ok then
              lspOpts = vim.tbl_deep_extend('keep', lsp_custom_opts, lspOpts)
              lspOpts.capabilities = require('blink.cmp').get_lsp_capabilities(lsp_custom_opts.capabilities)
            else
              lspOpts.capabilities = require('blink.cmp').get_lsp_capabilities({})
            end
            require('lspconfig')[server_name].setup(lspOpts)
          end,
        }
      })
    end
  }
}
