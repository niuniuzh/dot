-- Preview of the proposed configuration
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = { enable = true },
          shortcut = {
            { desc = "󰦛 Restore Session", group = "@property", action = "lua require('persistence').load()", key = "s" },
            { desc = "󰈞 Find File", group = "Label", action = "Telescope find_files", key = "f" },
            { desc = "󰊄 Recent Files", group = "Identifier", action = "Telescope oldfiles", key = "r" },
            { desc = "󰃁 Marked Files", group = "DiagnosticHint", action = "Telescope marks", key = "m" },
            { desc = " New File", group = "Number", action = "enew", key = "n" },
            { desc = "󰚰 Refresh", group = "String", action = "Dashboard", key = "u" },
          },
          project = {
            enable = true,
            limit = 8,
            label = 'Recent Projects',
            action = 'Telescope find_files cwd=',
          },
          mru = {
            enable = true,
            limit = 10,
            label = 'Recent Files',
          },
          footer = { "Dashboard enhanced by Antigravity" },
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
