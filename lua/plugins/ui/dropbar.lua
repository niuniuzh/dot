return {
  "Bekaboo/dropbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  event = "VeryLazy",
  config = function()
    -- 1. 必须先调用 setup()，否则插件核心组件不会加载
    require("dropbar").setup()

    -- 2. 修改此处：调用 api.pick()
    vim.keymap.set("n", "<leader>dr", function()
      require("dropbar.api").pick()
    end, { desc = "Pick Dropbar (面包屑导航)" })
  end,
}
