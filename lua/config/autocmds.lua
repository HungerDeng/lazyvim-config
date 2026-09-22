-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- This autocmd is the ordinary-terminal counterpart to the Snacks terminal
-- configuration in lua/plugins/snacks.lua. The responsibilities are kept
-- separate because `:terminal` buffers and Snacks terminals are both terminal
-- buffers, but they need different Escape behavior:
--
-- * ordinary `:terminal` buffers get a buffer-local single-<Esc> mapping here;
-- * Snacks terminals get their mapping from Snacks' own window configuration;
-- * LazyGit is a Snacks terminal, but opts out of that mapping so its <Esc>
--   key can be handled by LazyGit and return from a staging panel.
--
-- The mapping must be buffer-local. A global terminal-mode mapping would also
-- match LazyGit and consume <Esc> before the LazyGit process sees it. That is
-- why the global single-Escape mapping in lua/config/keymaps.lua is intentionally disabled.

-- Enter terminal mode when opening or focusing a terminal buffer
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
  pattern = "term://*",
  callback = function(args)
    if vim.bo[args.buf].buftype == "terminal" then
      -- Keep single-Escape terminal mode exit for ordinary `:terminal`
      -- buffers, but leave Snacks terminals (including LazyGit) alone.
      if args.event == "TermOpen" and not vim.b[args.buf].snacks_terminal then
        -- `buffer = args.buf` keeps this mapping limited to the ordinary
        -- terminal that triggered TermOpen; it cannot affect LazyGit or any
        -- other terminal buffer opened later.
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
          buffer = args.buf,
          silent = true,
          desc = "Exit terminal mode",
        })
      end

      vim.schedule(function()
        vim.cmd("startinsert")
      end)
    end
  end,
})

-- A directory passed to Neovim (for example, `nvim .`) can remain as a
-- hidden, listed buffer after Snacks replaces it with its explorer. If that
-- buffer is written into a Persistence session, restoring the session makes
-- Snacks interpret it as another request to open the explorer.
local function delete_directory_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" and vim.fn.isdirectory(name) == 1 then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "PersistenceSavePre", "PersistenceLoadPost" },
  callback = delete_directory_buffers,
})
