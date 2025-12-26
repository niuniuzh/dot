return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "0.9.3", -- 锁定版本以修复 'configs' 模块缺失问题
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "go", "lua", "vim", "vimdoc", "markdown",
          "html", "css", "javascript", "typescript", "tsx", "json" 
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
