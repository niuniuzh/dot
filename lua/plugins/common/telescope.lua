return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- [性能] fzf-native: C语言编写的高性能模糊搜索算法，极速排序
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make" 
      },
      -- [UI] ui-select: 将 Neovim 默认的列表选择替换为 Telescope 界面
      "nvim-telescope/telescope-ui-select.nvim",
      -- [图标] 大部分人都喜欢的文件图标支持
      "nvim-tree/nvim-web-devicons",
      "ahmedkhalf/project.nvim", 
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- [布局配置] 
          -- 采用水平布局，搜索框在上方(top)，预览窗口占55%宽度
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 0,
          },
          sorting_strategy = "ascending", -- 结果从上到下排列
          
          -- [外观微调]
          prompt_prefix = "🔍 ",  -- 搜索提示符
          selection_caret = " ", -- 选中行提示符
          path_display = { "truncate" }, -- 路径过长时智能截断
          
          -- [通用快捷键] 在 Telescope 窗口中的按键
          mappings = {
            -- 插入模式 (搜索时)
            i = {
              ["<C-j>"] = actions.move_selection_next,     -- Ctrl+j 下移 (比方向键快)
              ["<C-k>"] = actions.move_selection_previous, -- Ctrl+k 上移
              ["<C-n>"] = actions.cycle_history_next,      -- Ctrl+n 查看下一条历史搜索记录
              ["<C-p>"] = actions.cycle_history_prev,      -- Ctrl+p 查看上一条历史搜索记录
              ["<C-c>"] = actions.close,                   -- Ctrl+c 关闭窗口
            },
            -- 普通模式
            n = {
              ["q"] = actions.close, -- 按 q 快速退出
            },
          },
        },
        extensions = {
          -- [FZF 配置] 精确且快速
          fzf = {
            fuzzy = true,                   -- 开启模糊搜索
            override_generic_sorter = true, -- 覆盖默认的通用排序器
            override_file_sorter = true,    -- 覆盖默认的文件排序器
            case_mode = "smart_case",       -- 智能大小写：全小写忽略大小写，含大写则精确匹配
          },
          -- [UI Select 配置]
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- 可以在这里自定义 dropdown 的样式，比如边框等
            }),
          },
        },
      })

      -- [加载扩展] 必须显式加载已安装的扩展
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "projects") -- [新增] 加载项目管理扩展

      -- ==========================================
      --                快捷键配置
      -- ==========================================
      
      -- [基础文件操作]
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Telescope] 查找文件" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[Telescope] 历史文件 (Recent)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Telescope] 切换缓冲区" })
      vim.keymap.set("n", "<leader>fp", function() -- [新增]
        telescope.extensions.projects.projects()
      end, { desc = "[Telescope] 查找项目 (Projects)" })
      
      -- [全局搜索]
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Telescope] 全局搜索 (Live Grep)" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[Telescope] 搜索光标下单词 (Current Word)" })
      vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "[Telescope] 恢复上一次搜索 (Last)" }) -- 非常有用！

      -- [Git 集成]
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "[Telescope] 查看 Git 提交 (Commits)" })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[Telescope] 查看 Git 状态变化 (Status)" })

      -- [代码与配置]
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[Telescope] 代码诊断列表 (Diagnostics)" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[Telescope] 查找帮助文档" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[Telescope] 查看按键映射" })

      -- [特殊功能]
      -- 快速搜索你的 Neovim 配置文件，无需 cd 到目录
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[Telescope] 查找 Neovim 配置文件" })

    end,
  },
}
