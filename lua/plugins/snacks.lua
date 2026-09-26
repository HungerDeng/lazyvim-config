return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Swap the f-group keymaps: lowercase = cwd, uppercase = root dir.
      picker = {
        sources = {
          files = {
            win = {
              input = {
                keys = {
                  ["H"] = { "toggle_hidden", mode = "n" },
                  ["I"] = { "toggle_ignored", mode = "n" },
                },
              },
              list = {
                keys = {
                  ["H"] = "toggle_hidden",
                  ["I"] = "toggle_ignored",
                },
              },
            },
          },
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
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
    keys = {
      -- Explorer
      { "<leader>fe", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)" },
      { "<leader>fE", function() Snacks.explorer({ cwd = vim.fn.expand("~") }) end, desc = "Explorer Snacks (root dir)" },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks (cwd)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer Snacks (root dir)", remap = true },
      -- Find Files
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", function() Snacks.picker.files({ cwd = vim.fn.expand("~") }) end, desc = "Find Files (root dir)" },
      -- Recent
      { "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent (cwd)" },
      { "<leader>fR", function() Snacks.picker.recent({ cwd = vim.fn.expand("~") }) end, desc = "Recent (root dir)" },
    },
  },
}
