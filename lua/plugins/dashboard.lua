return {
  {
    -- https://github.com/goolord/alpha-nvim
    'goolord/alpha-nvim',
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 设置页眉
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      -- 设置菜单项
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings", ":e ~/.config/nvim<CR>"),
        dashboard.button("q", "󰅙  > Quit NVIM", ":qa<CR>"),
      }

      -- 设置页脚
      -- local function footer()
      --   return "github.com/goolord/alpha-nvim"
      -- end

      -- dashboard.section.footer.val = footer()

      -- 设置选项
      dashboard.opts.opts.noautocmd = true

      -- 应用配置
      alpha.setup(dashboard.opts)
    end
  },
}
