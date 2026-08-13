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

-- Swap LazyVim's default terminal keys: lowercase = cwd, uppercase = root dir
vim.keymap.set({ "n", "t" }, "<leader>ft", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle terminal (cwd)" })
vim.keymap.set({ "n", "t" }, "<leader>fT", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.expand("~") })
end, { desc = "Toggle terminal (root dir)" })
