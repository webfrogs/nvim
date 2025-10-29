-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    -- vim.keymap.set({ "n", "v" }, "<leader>l", function()
    --   conform.format({
    --     lsp_fallback = true,
    --     async = false,
    --     timeout_ms = 1000,
    --   })
    -- end, { desc = "Format file or range (in visual mode)" })
  end,
}
