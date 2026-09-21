return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next({ auto_insert = false })
            end

            if cmp.snippet_active({ direction = 1 }) then
              return cmp.snippet_forward()
            end

            return false
          end,
          "fallback",
        },

        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev({ auto_insert = false })
            end

            if cmp.snippet_active({ direction = -1 }) then
              return cmp.snippet_backward()
            end

            return false
          end,
          "fallback",
        },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
      },
    },
  },
}
