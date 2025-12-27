return {
  "ethanholz/nvim-lastplace",
  event = "BufReadPost", -- 优化加载速度：仅在读取缓冲区后加载
  config = function()
    require("nvim-lastplace").setup({
      lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
      lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
      lastplace_open_folds = true, -- 打开文件时自动展开光标所在处的折叠
    })
  end,
}