return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- Keep the plugin aligned with LazyVim's Markdown filetype integration.
      preset = "lazy",

      -- Complete Markdown checkboxes and callouts through the active LSP client.
      completions = {
        lsp = { enabled = true },
      },

      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },

      checkbox = {
        enabled = true,
        custom = {
          todo = {
            raw = "[-]",
            rendered = "󰥔 ",
            highlight = "RenderMarkdownTodo",
          },
        },
      },

      pipe_table = {
        preset = "round",
      },
    },
  },
}
