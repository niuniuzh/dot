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
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_SetFocusWhenToggle = 1
    local undo_dir = vim.fn.stdpath("data") .. "/undo"
    if vim.fn.isdirectory(undo_dir) == 0 then
      vim.fn.mkdir(undo_dir, "p")
    end
    vim.opt.undodir = undo_dir
    vim.opt.undofile = true
    vim.opt.undolevels = 10000 -- 撤销层级
  end,
}
