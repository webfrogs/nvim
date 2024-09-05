-- github: https://github.com/shellRaining/hlchunk.nvim
return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true
      },
      indent = {
        -- enable = true,
        chars = {
          "¦",
        },
        style = {
          "#9B9398",
        },
      },
    })
  end
}
