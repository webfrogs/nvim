-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    vim.keymap.set("n", "<leader>t", "<Cmd>Neotree<CR>")
    vim.keymap.set("n", "<leader>o", "<Cmd>Neotree reveal<CR>")
    vim.keymap.set("n", "<leader>b", "<Cmd>Neotree source=buffers<CR>")

    require("neo-tree").setup({
      enable_diagnostics = true,
      popup_border_style = "rounded",
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignore",
          },
        },
      },
      default_component_configs = {
        diagnostics = {
          symbols = {
            hint = "󰌵",
            info = "",
            warn = "",
            error = "",
          },
          highlights = {
            hint = "DiagnosticSignHint",
            info = "DiagnosticSignInfo",
            warn = "DiagnosticSignWarn",
            error = "DiagnosticSignError",
          },
        },
      },
      event_handlers = {
        {
          event = "file_added",
          handler = function(file_path)
            -- open file after created
            vim.cmd("edit " .. file_path)
          end,
        },
      },
    })
  end,
}
