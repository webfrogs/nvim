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
      -- Open Neo-tree without moving focus away from the restored window.
      function()
        local file = vim.api.nvim_buf_get_name(0)
        local args = { action = "show", source = "filesystem" }
        if vim.bo.buftype == "" and vim.fn.filereadable(file) == 1 then
          args.reveal_file = file
        end
        require("neo-tree.command").execute(args)
      end,
      -- trigger lsp and treesitter
      function()
        vim.cmd("e!")
      end,
    },
  },
}
