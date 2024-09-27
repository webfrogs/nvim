-- https://github.com/nvim-telescope/telescope.nvim
return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd" },
          },
        },
      }
      require('telescope').load_extension('fzf')

      -- keymaps
      vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>Telescope git_bcommits<cr>", { noremap = true, silent = true })
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
  },
}
