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
        -- Keep the active underline orange when diagnostics are present.
        -- Bufferline switches to severity-specific selected highlights for
        -- both the diagnostic indicator and the tab name, so each variant
        -- needs the same `sp` color to prevent the underline from changing.
        -- Diagnostic indicator/count highlights.
        diagnostic_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        hint_diagnostic_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        info_diagnostic_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        warning_diagnostic_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        error_diagnostic_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        -- Tab-name highlights used when the selected buffer has diagnostics.
        hint_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        info_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        warning_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
        error_selected = {
          sp = { attribute = "fg", highlight = "Constant" },
          underline = true,
        },
      },
    },
  },
}
