return {
  -- Key binding helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      preset = "modern",
      win = {
        anchor = "SE",
        col = vim.o.columns,
        row = vim.o.lines,
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
    },
  },
}
