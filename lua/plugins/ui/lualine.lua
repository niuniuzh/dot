return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 自定义: 获取系统内存占用率函数 (Linux)
    local function get_memory_usage()
      local f = io.open("/proc/meminfo", "r")
      if not f then return "" end
      local content = f:read("*a")
      f:close()
      
      local total = content:match("MemTotal:%s*(%d+)")
      local available = content:match("MemAvailable:%s*(%d+)")
      
      if total and available then
        local used_percentage = math.floor(((total - available) / total) * 100)
        -- 󰍛 是 Nerd Font 的内存图标，如果终端不支持可改为文本 "RAM:"
        return "󰍛 " .. used_percentage .. "%%"
      end
      return ""
    end

    require("lualine").setup({
      options = {
        theme = "solarized",
        globalstatus = true,
        -- 使用标准的 Nerd Fonts 分隔符
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          -- path = 1: 显示相对路径 (例如: lua/plugins/ui/lualine.lua)
          { 'filename', path = 1 },
        },
        lualine_x = {
          get_memory_usage, -- 新增: 内存占用
          'encoding', 
          'fileformat', 
          'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {
          -- 新增: 当前时间 (格式 23:59)
          { 'datetime', style = '%H:%M' },
          'location'
        }
      },
    })
  end,
}
