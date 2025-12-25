return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- 这里的 capabilities 依然需要
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls" },
      })

      -- 获取补全补全能力
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- --- 新的配置方式 (Neovim 0.11+) ---

      -- 1. 配置 Go LSP (gopls)
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      vim.lsp.enable("gopls") -- 启用并根据文件类型自动启动

      -- 2. 配置 Lua LSP (lua_ls)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- --- 快捷键设置 (推荐使用 LspAttach 自动命令) ---
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
          map("n", "gr", vim.lsp.buf.references, "Go to References")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          
          -- 诊断信息跳转（这些其实不依赖 LSP，但通常放在这里）
          map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })
    end,
  },
}
