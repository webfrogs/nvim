-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local support_langs = {
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

    require('nvim-treesitter').install(support_langs)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = support_langs,
      callback = function()
        vim.treesitter.start()
      end,
    })
    -- vim.api.nvim_create_user_command('TSSync', function()
    --   require 'nvim-treesitter'.install(support_langs)
    -- end, {})
  end,
}
