return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-mini/mini.icons",
"nvim-tree/nvim-web-devicons" },
  opts = {
    preset = "helix", 
    win = {
      border = "rounded", -- modern 预设默认已经是圆角
      padding = { 2, 2 }, -- 甚至可以增加内边距让它更好看
    },
    
    plugins = {
      spelling = { enabled = true }, -- 拼写建议
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end
}
