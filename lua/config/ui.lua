-- color scheme
local colorscheme = "nightfox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" }) -- 红色
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffcc00" })  -- 黄色

vim.diagnostic.config({
  -- disable virtual text
  virtual_text = false,
  -- update_in_insert = true,
  underline = true,
  -- severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- ensure called after LSP is loaded
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '󰌵',
        },
      },
    })
  end
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
