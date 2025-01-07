return {
  -- {
  --   "olexsmir/gopher.nvim",
  --   ft = "go",
  --   config = function(_, opts)
  --     require("gopher").setup(opts)
  --   end,
  --   keys = {
  --     { "<leader>gta", "<cmd>GoTestAdd<cr>", "n", desc = "generate one test for current function/method" },
  --     { "<leader>gie", "<cmd>GoIfErr<cr>",   "n", desc = "generate 'if error'" },
  --   },
  -- },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    keys = {
      { "<leader>gta", "<cmd>GoAddTest<cr>", "n", desc = "generate one test for current function/method" },
      { "<leader>gie", "<cmd>GoIfErr<cr>",   "n", desc = "generate 'if error'" },
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
  },
}
