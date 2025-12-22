return {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
        notify_on_error = false,
        formatters = {
            odinfmt = {
                -- Change where to find the command if it isn't in your path.
                command = "odinfmt",
                args = { "-stdin" },
                stdin = true,
            },
        },
        formatters_by_ft = {
            astro = { "prettierd", "rustywind" },
            javascript = { "prettierd" },
            typ = { "typstyle" },
            typst = { "typstyle" },
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            json = { "prettierd", "eslint_d" },
            jsonc = { "prettierd", "eslint_d" },
            css = { "prettierd" },
            scss = { "prettierd" },
            yaml = { "prettierd" },
            html = { "rustywind" },
            markdown = { "rustywind" },
            lua = { "stylua" },
            java = { "google-java-format" },
            cpp = { "clang-format", "astyle" },
            c = { "clang-format", "astyle" },
            proto = { "clang-format" },
            rust = { "rustfmt" },
            go = { "goimports", "gofmt" },
            templ = { "templ" },
            odin = { "odinfmt" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            stop_after_first = true,
        },
        notify_no_formatters = true,
    },
}
