return {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
        formatters_by_ft = {
            astro = { "rustywind", "prettierd" },
            javascript = { "prettierd" },
            typ = { "typstyle" },
            typst = { "typstyle" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            json = { "prettierd" },
            css = { "prettierd" },
            scss = { "prettierd" },
            yaml = { "prettier" },
            html = { "rustywind" },
            eruby = { "rustywind" },
            markdown = { "rustywind" },
            lua = { "stylua" },
            java = { "google-java-format" },
            cpp = { { "clang-format", "astyle" } },
            c = { { "clang-format", "astyle" } },
            rust = { { "rustfmt", "rustfmt-nightly" } },
            python = { "black" },
            go = { "goimports", "gofmt" },
            templ = { "templ" },
            nix = { "nixfmt" },
        },
    },
}