return {
  {
    "devswiftzone/swift.nvim",
    ft = "swift",
    opts = {
      features = {
        lsp = {
          on_attach = function(_, bufnr)
            -- swift.nvim binds <leader>e to the diagnostic float window on
            -- attach, which shadows LazyVim's global explorer binding.
            -- Remove it so <leader>e keeps opening the explorer.
            vim.keymap.del("n", "<leader>e", { buffer = bufnr })
          end,
        },
      },
    },
  },
}
