-- https://github.com/rmagatti/auto-session
local function clear_neo_tree_buffers()
  require("neo-tree.command").execute({ action = "close" })
  -- Restored buffers are not registered in Neo-tree's state, so close misses them.
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
    if vim.bo[buf].filetype == "neo-tree"
      or (name:match("^neo%-tree .+ %[%d+%]$") and not vim.api.nvim_buf_is_loaded(buf)) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
    pre_save_cmds = { clear_neo_tree_buffers },
    post_restore_cmds = {
      -- Open Neo-tree without moving focus away from the restored window.
      function()
        clear_neo_tree_buffers()
        local file = vim.api.nvim_buf_get_name(0)
        local args = { action = "show", source = "filesystem" }
        if vim.bo.buftype == "" and vim.fn.filereadable(file) == 1 then
          args.reveal_file = file
        end
        require("neo-tree.command").execute(args)
      end,
      -- trigger lsp and treesitter
      function()
        if vim.bo.buftype == "" and vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
          vim.cmd("e!")
        end
      end,
    },
  },
}
