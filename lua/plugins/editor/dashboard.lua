return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper", -- 现代感极强的风格
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            -- 在这里集成选择逻辑
            { desc = "󰦛 Restore Session", group = "@property", action = "lua require('persistence').load()", key = "s" },
            { desc = "󰈞 Find File", group = "Label", action = "Telescope find_files", key = "f" },
            { desc = "󰊄 Recent Files", group = "Identifier", action = "Telescope oldfiles", key = "r" },
            { desc = " New File", group = "Number", action = "enew", key = "n" },
          },
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
