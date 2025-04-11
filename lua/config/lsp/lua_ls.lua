return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
          -- [vim.fn.stdpath("data") .. "/lazy/flash.nvim/lua"] = true,
          -- [vim.fn.stdpath("data") .. "/lazy/snacks.nvim/lua"] = true,
        },
      },
    },
  },
}
