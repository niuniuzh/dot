return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvim-telescope/telescope.nvim", -- 确保 telescope 是依赖
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls" },
      })

      -- 获取补全能力
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- --- LSP 服务配置 (Neovim 0.11+) ---

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
      vim.lsp.enable("gopls")

      -- 2. 配置 Lua LSP (lua_ls)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- --- 自动关闭 Quickfix 窗口的设置 ---
      -- 防止某些操作退回到传统的 quickfix 窗口而不关闭
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
          vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
        end,
      })

      -- --- 快捷键设置 (LspAttach) ---
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          local ts = require('telescope.builtin')

          -- 基础 LSP 功能
          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

          -- 使用 Telescope 增强的跳转功能 (自动处理多个定义的情况)
          map("n", "gd", ts.lsp_definitions, "Go to Definition")
          map("n", "gr", ts.lsp_references, "Go to References")
          map("n", "gi", ts.lsp_implementations, "Go to Implementation")
          map("n", "gt", ts.lsp_type_definitions, "Type Definition")
          
          -- 符号搜索
          map("n", "<leader>ds", ts.lsp_document_symbols, "Document Symbols")
          map("n", "<leader>ws", ts.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          -- 诊断信息
          map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("n", "<leader>D", ts.diagnostics, "Workspace Diagnostics")
        end,
      })
    end,
  },
}
