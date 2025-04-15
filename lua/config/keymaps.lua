-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Editor
keymap("n", "<C-/>", ":CommentToggle<cr>", opts)
keymap("v", "<C-/>", ":CommentToggle<cr>", opts)
keymap("n", "<C-_>", ":CommentToggle<cr>", opts)
keymap("v", "<C-_>", ":CommentToggle<cr>", opts)

keymap("n", "<leader>1", ":noh<cr>", opts)
keymap("n", "<leader>2", ":cclose<cr>", opts)
keymap("n", "<leader>3", ":tabclose<cr>", opts)

-- System clipboard
keymap("n", "<leader>y", "\"+y", opts)
keymap("n", "<leader>p", "\"+p", opts)

-- copy current file and cursor line to clipboard
keymap("n", "<leader>l", ":let @+ = expand(\"%\") . \":\" . line(\".\")<CR>", opts)
