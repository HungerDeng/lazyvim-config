-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Terminal mode cursor: thin line (vertical bar) instead of a block
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"

-- Keep the cursor centered while scrolling
vim.opt.scrolloff = 999

-- Wrap long lines in all buffers
vim.opt.wrap = true

-- Keep accepted spell-check words versioned with this configuration.
vim.opt.spellfile = { vim.fn.stdpath("config") .. "/spell/en.utf-8.add" }

-- Keep English spell checking, but do not mark Chinese/East Asian characters
-- as misspelled in prose buffers where LazyVim enables spell checking.
vim.opt.spelllang = { "en", "cjk" }

-- forbidden the autoformat
vim.g.autoformat = false
