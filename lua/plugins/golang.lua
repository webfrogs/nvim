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
      require("go").setup({
        tag_transform = "camelcase",
      })
    end,
    keys = {
      { "<leader>gat",  "<cmd>GoAddTest<cr>",     "n", desc = "generate one test for current function/method" },
      { "<leader>gie",  "<cmd>GoIfErr<cr>",       "n", desc = "generate 'if error'" },
      { "<leader>gsat", "<cmd>GoAddTag json<cr>", "n", desc = "generate go struct json tag with camelcase style" },
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
  },
}
