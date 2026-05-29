-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>1", ":noh<cr>", opts)
keymap("n", "<leader>2", ":cclose<cr>", opts)
keymap("n", "<leader>3", ":tabclose<cr>", opts)
keymap("n", "<C-l>", ":e!<cr>", opts)

-- System clipboard
keymap("n", "<leader>y", "\"+y", opts)
keymap("n", "<leader>p", "\"+p", opts)

-- copy current file and cursor line to clipboard
keymap("n", "<leader>l", ":let @+ = expand(\"%\") . \":\" . line(\".\")<CR>", opts)

-- copy relative file path to clipboard
vim.keymap.set("n", "<leader>f", function()
  if vim.bo.filetype == "neo-tree" then return end
  vim.fn.setreg("+", vim.fn.fnamemodify(vim.fn.expand("%"), ":."))
end, opts)
