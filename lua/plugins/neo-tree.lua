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
    -- vim.diagnostic.config({
    --   signs = {
    --     error = { text = "✘", texthl = "DiagnosticError" }, -- 错误
    --     warn  = { text = "⚠", texthl = "DiagnosticWarn" }, -- 警告
    --     info  = { text = "ℹ", texthl = "DiagnosticInfo" }, -- 信息
    --     hint  = { text = "➤", texthl = "DiagnosticHint" }, -- 提示
    --   }
    -- })
    -- vim.diagnostic.config({
    --   signs = {
    --     text = {
    --       [vim.diagnostic.severity.ERROR] = '',
    --       [vim.diagnostic.severity.WARN] = '',
    --       [vim.diagnostic.severity.INFO] = '',
    --       [vim.diagnostic.severity.HINT] = '󰌵',
    --     },
    --   }
    -- })
    -- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    -- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    -- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    -- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
      enable_diagnostics = true,
      popup_border_style = "rounded",
      window = {
        width = 30,
      },
    })
  end,
}
