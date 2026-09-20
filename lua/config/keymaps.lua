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

-- Tab / Shift+Tab to indent/dedent in visual-line mode
vim.keymap.set("x", "<Tab>", function()
  -- ">gv" meaning:
  -- ">": indicates appling ">" to indent the line
  -- "gv": re-enter the visual-line mode, preserving already selected lines
  return vim.fn.mode() == "V" and ">gv" or "<Tab>"
end, { expr = true, noremap = true, silent = true, desc = "Indent line selection" })
vim.keymap.set("x", "<S-Tab>", function()
  -- similar to the ">gv"
  return vim.fn.mode() == "V" and "<gv" or "<S-Tab>"
end, { expr = true, noremap = true, silent = true, desc = "Dedent line selection" })

-- gh / gl to jump back/forward in the jump list (like Ctrl-O / Ctrl-I)
vim.keymap.set("n", "gh", "<C-o>", { desc = "Jump back (like Ctrl-O)" })
vim.keymap.set("n", "gl", "<C-i>", { desc = "Jump forward (like Ctrl-I)" })

-- [[ buffers related keymap start ]]
-- built-in keymap: shift+h (H) to switch to the left buffers
-- built-in keymap: shift+l (L) to switch to the right buffers
--
vim.keymap.set("n", "<D-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer to the Left" })
vim.keymap.set("n", "<D-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer to the Right" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<leader>br", function()
  Snacks.picker.recent({ filter = { cwd = true } })
end, { desc = "Buffers Recent" })

-- Open the buffer picker with the list focused in normal mode.
vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers({ focus = "list" })
end, { desc = "Buffers (Normal Mode)" })

vim.keymap.set("n", "<leader>bt", function()
  if vim.o.showtabline == 0 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = "Toggle Bufferline" })
-- [[ buffers related keymap end ]]

-- clear the highlight
vim.keymap.set("n", "<Leader><Leader>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Terminal Escape handling is intentionally split across this file,
-- lua/plugins/snacks.lua, and lua/config/autocmds.lua:
--
-- 1. lua/plugins/snacks.lua gives Snacks-created terminal buffers 
--    (via <leader>ft, <leader>fT, or <Ctrl-/>) a single <Esc> mapping, 
--    while explicitly disabling that mapping for LazyGit.
-- 2. lua/config/autocmds.lua gives ordinary `:terminal` buffers their own
--    buffer-local single-<Esc> mapping.
-- 3. This file MUST NOT install a global terminal-mode <Esc> mapping. A global
--    mapping applies to every terminal buffer, including LazyGit, and **consumes
--    the Escape key before LazyGit** can use it to leave a staging panel.
--
-- Keeping the global mapping below DISABLED is therefore part of the design:
-- the two more specific configurations can **coexist without competing for
-- Escape**, and each terminal application receives the behavior it expects.
-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Swap LazyVim's default terminal keys: lowercase = cwd, uppercase = root dir
vim.keymap.set({ "n", "t" }, "<leader>ft", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle terminal (cwd)" })
vim.keymap.set({ "n", "t" }, "<leader>fT", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.expand("~") })
end, { desc = "Toggle terminal (root dir)" })
