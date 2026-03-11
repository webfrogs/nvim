return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
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
  end,
}
