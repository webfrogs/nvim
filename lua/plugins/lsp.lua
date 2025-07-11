return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
        vim.fn.stdpath("data") .. "/lazy/",
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
      },
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = true,
          },
        },
        keymap = {
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
      -- mason: https://github.com/mason-org/mason.nvim
      { "mason-org/mason.nvim", opts = {} },
      -- mason-lspconfig: https://github.com/williamboman/mason-lspconfig.nvim
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "gopls",
            "golangci_lint_ls",
            "clangd",
            -- "pyright",
            "ts_ls",
            "bashls",
            "buf_ls",
          },
        },
      },
      { 'saghen/blink.cmp' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- folding
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
          -- Inlay hint
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- vim.lsp.inlay_hint.enable()
            vim.keymap.set('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
          end

          -- -- Highlight words under cursor
          -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) and vim.bo.filetype ~= 'bigfile' then
          --   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          --     buffer = event.buf,
          --     group = highlight_augroup,
          --     callback = vim.lsp.buf.document_highlight,
          --   })

          --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          --     buffer = event.buf,
          --     group = highlight_augroup,
          --     callback = vim.lsp.buf.clear_references,
          --   })

          --   vim.api.nvim_create_autocmd('LspDetach', {
          --     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          --     callback = function(event2)
          --       vim.lsp.buf.clear_references()
          --       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          --       -- vim.cmd 'setl foldexpr <'
          --     end,
          --   })
          -- end
        end,
      })

      -- lsp keymap
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: hover' })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = 'LSP: rename' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: declaration' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: implementation' })
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'LSP: open float' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: references' })
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'LSP: signature help' })
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP: action' })
      -- Diagnostics
      vim.keymap.set('n', '<leader>ld', function()
        vim.diagnostic.open_float { source = true }
      end, { desc = 'LSP: Show Diagnostic' })

      -- load custom lsp config
      local custom_lsp_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/config/lsp/*.lua", false, true)
      for _, file in ipairs(custom_lsp_files) do
        local module_path = file:gsub(".*/lua/(.*)%.lua$", "%1"):gsub("/", ".")
        local lsp_name = module_path:match(".*%.(.*)$")
        vim.lsp.config[lsp_name] = require(module_path)
      end
    end
  }
}
