-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "J", "25j", { desc = "Move down 25 lines" })
vim.keymap.set("n", "K", "25k", { desc = "Move up 25 lines" })
vim.keymap.set("n", "W", "10w", { desc = "Move forward 10 words" })
vim.keymap.set("n", "B", "10b", { desc = "Move back 10 words" })
vim.keymap.set("x", "J", function()
  return vim.fn.mode() == "V" and "10j" or "J"
end, { expr = true, desc = "Move down 10 lines in visual-line mode" })
vim.keymap.set("x", "K", function()
  return vim.fn.mode() == "V" and "10k" or "K"
end, { expr = true, desc = "Move up 10 lines in visual-line mode" })
vim.keymap.set("x", "W", function()
  return vim.fn.mode() == "v" and "10w" or "W"
end, { expr = true, desc = "Move forward 10 words in visual mode" })
vim.keymap.set("x", "B", function()
  return vim.fn.mode() == "v" and "10b" or "B"
end, { expr = true, desc = "Move back 10 words in visual mode" })

-- gh / gl to jump back/forward in the jump list (like Ctrl-O / Ctrl-I)
vim.keymap.set("n", "gh", "<C-o>", { desc = "Jump back (like Ctrl-O)" })
vim.keymap.set("n", "gl", "<C-i>", { desc = "Jump forward (like Ctrl-I)" })

-- clear the highlight
vim.keymap.set("n", "<Leader><Leader>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Exit terminal mode easily with Escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Swap LazyVim's default terminal keys: lowercase = cwd, uppercase = root dir
vim.keymap.set({ "n", "t" }, "<leader>ft", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle terminal (cwd)" })
vim.keymap.set({ "n", "t" }, "<leader>fT", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.expand("~") })
end, { desc = "Toggle terminal (root dir)" })
