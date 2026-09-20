return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Escape handling is coordinated with lua/config/keymaps.lua and
      -- lua/config/autocmds.lua. The global terminal-mode <Esc> mapping in
      -- keymaps.lua must remain disabled; otherwise it would also intercept
      -- Escape inside LazyGit and prevent LazyGit from handling its own panel
      -- navigation. Ordinary `:terminal` buffers are handled by the
      -- buffer-local TermOpen mapping in autocmds.lua instead.
      terminal = {
        win = {
          keys = {
            -- replaces Snacks' "double escape to normal mode" behavior with a single Escape.
            -- "double escape to normal mode": need to press <Esc> twice in a row VERY FAST to exit terminal mode BY DEFAULT.
            term_normal = {
              "<Esc>",
              function()
                return [[<C-\><C-n>]]
              end,
              mode = "t",
              expr = true,
              desc = "Exit terminal mode",
            },
          },
        },
      },
      lazygit = {
        win = {
          keys = {
            -- LazyGit is implemented by Snacks on top of Snacks.terminal.
            -- That means it would inherit terminal.keys.term_normal above
            -- unless this key is explicitly disabled. With no Neovim-side
            -- <Esc> mapping here, the key reaches LazyGit itself so it can
            -- return from a staging panel to its main panel.
            term_normal = false,
          },
        },
        config = {
          gui = {
            theme = {
              selectedLineBgColor = {
                "#e5e7eb",
              },
            },
          },
        },
      },
    },
  },
}
