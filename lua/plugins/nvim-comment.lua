-- https://github.com/terrortylor/nvim-comment
return {
  "terrortylor/nvim-comment",
  config = function()
    require('nvim_comment').setup({
      -- should comment out empty or whitespace only lines
      comment_empty = false,
    })
    vim.api.nvim_set_keymap("n", "<C-/>", ":CommentToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-/>", ":CommentToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-_>", ":CommentToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-_>", ":CommentToggle<cr>", { noremap = true, silent = true })
  end,
}
