-- Swap the f-group keymaps: lowercase = cwd, uppercase = root dir.
return {
  {
    "folke/snacks.nvim",
    opts = {
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
