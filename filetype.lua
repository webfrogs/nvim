vim.g.do_filetype_lua = 1    -- use filetype.lua
vim.g.did_load_filetypes = 0 -- disable filetype.vim

vim.filetype.add({
  extension = {
    pn = "potion",
    sh = "sh",
    sql = "sql",
    xml = "xml",
    c = "c",
    go = "go",
    h = function(_, bufnr)
      local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, true);
      for i = 1, #first_line do
        if first_line[i]:match('<iostream>') then
          return "cpp"
        end
      end
      return "c"
    end,
    conf = function(path, _)
      -- 获取当前文件所在目录的父目录（即上一级目录）
      local parent_of_file_dir = vim.fn.fnamemodify(path, ':h:h')
      -- 检查该父目录中是否存在 hyprland.conf
      local hyprland_conf = vim.fn.join({ parent_of_file_dir, 'hyprland.conf' }, '/')
      if vim.fn.filereadable(hyprland_conf) == 1 then
        return "hyprlang"
      end
      -- 继续探测上一级路径
      parent_of_file_dir = vim.fn.fnamemodify(parent_of_file_dir, ':h')
      hyprland_conf = vim.fn.join({ parent_of_file_dir, 'hyprland.conf' }, '/')
      if vim.fn.filereadable(hyprland_conf) == 1 then
        return "hyprlang"
      end
      return "conf"
    end,
  },
  filename = {
    [".git/config"] = "gitconfig",
    ["~/.config/mutt/muttrc"] = "muttrc",
    -- ["README$"] = function(path, bufnr)
    --   if string.find("#", vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)) then
    --     return "markdown"
    --   end
    --   -- no return means the filetype won't be set and to try the next method
    -- end,
  },
})
