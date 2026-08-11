return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Override LazyVim's K (LSP hover): jump up 25 lines instead.
            -- Registered after LazyVim's default keys, so it takes precedence.
            { "K", "25k", desc = "Move up 25 lines" },
            -- Keep hover available on <leader>K
            { "<leader>K", vim.lsp.buf.hover, desc = "Hover" },
          },
        },
      },
    },
  },
}
