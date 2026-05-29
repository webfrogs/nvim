-- https://github.com/rmagatti/auto-session
return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
    post_restore_cmds = {
      -- open neotree and move cusor back to current file
      function()
        vim.cmd("Neotree reveal_file=" .. vim.fn.expand("%:p"))
        vim.cmd("wincmd p")
      end,
      -- trigger lsp and treesitter
      function()
        vim.cmd("e!")
        -- vim.defer_fn(function()
        --   vim.cmd("e!")
        -- end, 300)
      end,
    },
  },
}
