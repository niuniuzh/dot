return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- 在读取缓冲区前初始化
  opts = {
    need = 0,
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
    branch = true,
  },
}