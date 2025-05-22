return {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            -- ["<CR>"] = { "accept", "fallback" },
            -- ["<Tab>"] = {
            --     function(cmp)
            --         if cmp.snippet_active() then
            --             return cmp.accept()
            --         else
            --             return cmp.select_and_accept()
            --         end
            --     end,
            --     "snippet_forward",
            --     "fallback",
            -- },
            ["<C-y>"] = { "select_and_accept" },
            ["<C-z>"] = { "select_and_accept" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
        },

        completion = { documentation = { auto_show = true } },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },
        signature = { enabled = true },
    },
}
