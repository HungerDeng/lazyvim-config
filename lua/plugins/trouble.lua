local function toggle_symbols()
  local trouble = require("trouble")

  local open_views = require("trouble.view").get({ open = true, mode = "symbols" })
  local current_view = open_views[#open_views] and open_views[#open_views].view
  if current_view and current_view:is_open() then
    local panel_focused = vim.api.nvim_get_current_win() == current_view.win.win
    local item = panel_focused and current_view:at().item or nil
    local main = current_view:main()

    trouble.close({ mode = "symbols" })

    if panel_focused and main and item and item.buf == main.buf and vim.api.nvim_win_is_valid(main.win) then
      vim.api.nvim_set_current_win(main.win)
      vim.api.nvim_win_set_cursor(main.win, item.pos)
      vim.api.nvim_win_call(main.win, function()
        vim.cmd("normal! zzzv")
      end)
    end
    return
  end

  local view = trouble.toggle({
    mode = "symbols",
    auto_preview = false,
    focus = false,
    pinned = true,
  })

  if not view then
    return
  end

  view:wait(function()
    vim.defer_fn(function()
      if not view:is_open() then
        return
      end

      local main = view:main()
      if not main or not vim.api.nvim_win_is_valid(main.win) then
        return
      end

      vim.api.nvim_set_current_win(main.win)
      require("trouble.view").follow(view)
      view.opts.auto_preview = true
      view.win:focus()
    end, 50)
  end)
end

return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>cs",
        toggle_symbols,
        desc = "Symbols (Trouble)",
      },
    },
    opts = {
      modes = {
        symbols = {
          focus = false,
          follow = true,
          pinned = true,
          win = { position = "right", size = 0.4 },
        },
      },
    },
  },
}
