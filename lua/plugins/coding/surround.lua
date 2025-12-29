return {
  "kylechui/nvim-surround",
  version = "*", -- 使用稳定版本
  event = "VeryLazy", -- 延迟加载以优化启动速度
  config = function()
    require("nvim-surround").setup({
      -- 这里可以进行自定义配置，默认配置已经非常强大
    })
  end,
}