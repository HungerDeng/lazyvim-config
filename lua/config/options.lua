-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.title = true
vim.opt.titlelen = 0

-- Terminal mode cursor: thin line (vertical bar) instead of a block
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"

-- Keep the cursor centered while scrolling
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 999

local function git_branch()
  local result = vim
    .system({ "git", "branch", "--show-current" }, {
      text = true,
      cwd = vim.fn.getcwd(),
    })
    :wait()

  if result.code ~= 0 then
    return ""
  end

  local branch = vim.trim(result.stdout or "")
  if branch == "" then
    return ""
  end

  return " [" .. branch .. "]"
end

local function update_terminal_title()
  local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  if project == "" then
    project = vim.fn.getcwd()
  end
  vim.opt.titlestring = project .. git_branch() .. ""
end

local title_group = vim.api.nvim_create_augroup("user_terminal_title", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged", "BufEnter" }, {
  group = title_group,
  callback = update_terminal_title,
})

update_terminal_title()
