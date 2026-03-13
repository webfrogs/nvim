-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    vim.api.nvim_create_user_command('TSSync', function()
      require 'nvim-treesitter'.install {
        "go",
        "lua",
        "cpp",
        "c",
        "python",
        "rust",
        "bash",
        "markdown",
        "markdown_inline",
      }
    end, {})
  end,
}
