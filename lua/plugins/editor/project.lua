return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- 探测项目根目录的标识
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod" },
      -- 自动切换到项目根目录
      silent_chdir = false,
      -- 忽略某些目录
      datapath = vim.fn.stdpath("data"),
    })
  end,
}