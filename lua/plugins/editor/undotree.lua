-- plugins/undotree.lua
return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow" },
  keys = {
    {
      "<leader>u",
      "<cmd>UndotreeToggle<CR>",
      desc = "Undo Tree",
    },
  },
  init = function()
    -- 必须在插件加载前设置的全局变量
    vim.g.undotree_WindowLayout = 2      -- 右侧
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_HelpLine = 0
  end,
  config = function()

    -- undo 存储目录
    local undo_dir = vim.fn.stdpath("data") .. "/undo"
    if not vim.loop.fs_stat(undo_dir) then
      vim.fn.mkdir(undo_dir, "p")
    end
    vim.opt.undodir = undo_dir
    -- 开启持久化撤销功能
    if vim.fn.has("persistent_undo") == 1 then
      vim.opt.undofile = true
    end
  end,
}
