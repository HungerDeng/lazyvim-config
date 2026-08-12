-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "J", "25j", { desc = "Move down 25 lines" })
vim.keymap.set("n", "K", "25k", { desc = "Move up 25 lines" })

-- gh / gl to jump back/forward in the jump list (like Ctrl-O / Ctrl-I)
vim.keymap.set("n", "gh", "<C-o>", { desc = "Jump back (like Ctrl-O)" })
vim.keymap.set("n", "gl", "<C-i>", { desc = "Jump forward (like Ctrl-I)" })

-- clear the highlight
vim.keymap.set("n", "<Leader><Leader>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Exit terminal mode easily with Escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Toggle terminal: show/hide the terminal window without exiting the shell
local function toggle_terminal(vertical)
  local tab = vim.api.nvim_get_current_tabpage()
  local wins = vim.api.nvim_tabpage_list_wins(tab)
  for _, win in ipairs(wins) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "terminal" then
      if #wins > 1 then
        vim.api.nvim_win_hide(win)
      else
        vim.notify("Cannot hide the only window", vim.log.levels.WARN)
      end
      return
    end
  end

  local buf
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) and vim.bo[b].buftype == "terminal" then
      buf = b
      break
    end
  end

  if buf then
    vim.cmd(vertical and "botright vsplit" or "botright split")
    vim.api.nvim_win_set_buf(0, buf)
  else
    vim.cmd(vertical and "botright vsplit | term" or "botright split | term")
  end
end

vim.keymap.set("n", "<leader>th", function()
  toggle_terminal(false)
end, { desc = "Toggle terminal (horizontal)" })

vim.keymap.set("n", "<leader>tv", function()
  toggle_terminal(true)
end, { desc = "Toggle terminal (vertical)" })

-- Swap LazyVim's default terminal keys: lowercase = cwd, uppercase = root dir
vim.keymap.set("n", "<leader>ft", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
vim.keymap.set("n", "<leader>fT", function() Snacks.terminal(nil, { cwd = vim.fn.expand("~") }) end, { desc = "Terminal (root dir)" })
