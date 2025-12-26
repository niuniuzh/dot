return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'light' -- Ensure background is set to light
      vim.cmd.colorscheme 'solarized'
    end,
  },
}
