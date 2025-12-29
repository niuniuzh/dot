return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    -- 实时显示“谁在什么时候在那一行写了什么” (Blame)
    current_line_blame = true, 
    current_line_blame_opts = {
      delay = 500, -- 延迟500ms显示，避免晃眼
      virt_text_pos = "eol", -- 显示在行尾
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- 导航 (跳转到下一个/上一个修改块)
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")

      -- 常用操作
      map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
      map("v", "<leader>ghs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, "Stage Hunk")
      map("v", "<leader>ghr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk (Diff)")
      
      -- Blame
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line (Full)")
      map("n", "<leader>ghB", gs.toggle_current_line_blame, "Toggle Blame Line")
      
      -- Diff
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      
      -- Text object (让你可以按 ih 选中一个 Git 修改块)
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
