return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
      })

      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      -- Include the next few lines until the comment only if you feel you need it
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>db', function()
        require('dap').toggle_breakpoint()
      end)
      vim.keymap.set('n', '<Leader>dB', function()
        require('dap').set_breakpoint(vim.fn.input '[Condition] > ')
      end)
      vim.keymap.set('n', '<F4>', function() require('dap').terminate() end)
      vim.keymap.set('n', '<F5>', function()
        vim.cmd('NvimTreeClose')
        require('dap').continue()
      end)
      vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)


      vim.keymap.set('n', '<Leader>lp', function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

      -- vim.keymap.set('n', '<Leader>w', function() dapui.open() end)
      -- vim.keymap.set('n', '<Leader>W', function() dapui.close() end)
    end
  },
  -- {
  --   -- https://github.com/Weissle/persistent-breakpoints.nvim
  --   'Weissle/persistent-breakpoints.nvim',
  --   config = function()
  --     require('persistent-breakpoints').setup {
  --       load_breakpoints_event = { "BufReadPost" }
  --     }
  --   end
  -- },
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   config = function()
  --     require("nvim-dap-virtual-text").setup {
  --       enabled = true,                     -- enable this plugin (the default)
  --       enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  --       highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  --       highlight_new_as_changed = true,    -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  --       show_stop_reason = true,            -- show stop reason when stopped for exceptions
  --       commented = false,                  -- prefix virtual text with comment string
  --       -- experimental features:
  --       virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
  --       all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  --       virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
  --       virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
  --     }
  --   end
  -- },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end
  },
}
