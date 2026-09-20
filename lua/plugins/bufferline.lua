return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- numbers = "ordinal",
        show_buffer_close_icons = false,
        indicator = {
          style = "underline",
        },
      },
      highlights = {
        buffer_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        -- numbers_selected = {
        --   sp = { attribute = "fg", highlight = "Constant" },
        --   underline = true,
        -- },
        indicator_selected = {
          fg = { attribute = "fg", highlight = "Constant" },
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
      },
    },
  },
}
