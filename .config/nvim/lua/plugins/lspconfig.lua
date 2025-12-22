return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- 1. Setup Mason (Package Manager)
            require("mason").setup()

            local ensure_installed = {
                "astro",
                "svelte",
                "gopls",
                "templ",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "jsonls",
                "marksman",
                "yamlls",
                "lemminx",
                "jdtls",
                "biome",
                "rust_analyzer",
                "taplo",
                "clangd",
                "ols",
            }

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_installation = true,
            })

            -- 2. Global Defaults (Capabilities & Signs)
            local blink = require("blink.cmp")
            local capabilities = blink.get_lsp_capabilities()

            -- Apply capabilities to *all* servers by default
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Diagnostics signs
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- 3. LspAttach Autocommand (Replaces on_attach)
            -- This runs every time an LSP attaches to a buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    -- Enable inlay hints if supported
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end

                    -- Helper for keymaps
                    local function map(mode, lhs, rhs, opts)
                        opts = opts or {}
                        opts.buffer = args.buf
                        opts.silent = true
                        opts.noremap = true
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    -- Client-specific Keymaps & Actions
                    if client.name == "tsgo" then
                        map("n", "<leader>lrf", function()
                            vim.lsp.buf.code_action({ apply = true, kind = "source.organizeImports" })
                        end, { desc = "Organize imports / Rename file" })
                        map("n", "<leader>loi", function()
                            vim.lsp.buf.code_action({ apply = true, kind = "source.organizeImports" })
                        end, { desc = "Organize imports" })
                        map("n", "<leader>lru", function()
                            vim.lsp.buf.code_action({ apply = true, kind = "source.removeUnused" })
                        end, { desc = "Remove unused imports" })
                        map("n", "gs", vim.lsp.buf.definition, { desc = "Go to source definition" })
                    end

                    if client.name == "gopls" then
                        -- Check if your core.format module exists before calling
                        local ok, fmt = pcall(require, "core.format")
                        if ok then
                            fmt.set_format_on_save(true)
                        end
                    end
                end,
            })

            -- 4. Server Configurations
            -- We configure servers using vim.lsp.config().
            -- Note: 'nvim-lspconfig' plugin provides the default `cmd` and `root_markers`
            -- automatically when we refer to the server by name.

            local util = require("lspconfig.util")

            -- Go
            vim.lsp.config("gopls", {
                filetypes = { "go", "gomod", "gosum" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                        analyses = { unusedparams = true },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            })

            -- Templ
            vim.lsp.config("templ", {
                root_markers = { "go.mod", ".git" },
                settings = {
                    templ = {
                        files = { exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" } },
                    },
                },
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                root_markers = { "Cargo.toml" },
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importPrefix = "by_self",
                            importGranularity = "module",
                            importPrefixStrictness = "off",
                        },
                    },
                },
            })

            -- Odin
            vim.lsp.config("ols", {
                root_markers = { "ols.json", ".git" },
                init_options = {
                    checker_args = "-strict-style",
                    enable_semantic_tokens = true,
                    enable_document_symbols = true,
                    enable_hover = true,
                    enable_snippets = true,
                },
            })

            -- TOML
            vim.lsp.config("taplo", {
                root_markers = { ".git" },
                settings = {
                    taplo = {
                        format = {
                            command = "taplo",
                            args = { "format", "--check" },
                        },
                    },
                },
            })

            -- C/C++
            vim.lsp.config("clangd", {
                -- Native root finding: search up for these markers
                root_markers = { ".git", "compile_commands.json", "compile_flags.txt", ".ccls-root" },
                init_options = {
                    clangdFileStatus = true,
                    recurseGlob = true,
                    fallbackFlags = { inherit = true, warnings = { clang_tidy_checks = "*" } },
                    completion = {
                        enable = true,
                        completeEnumCase = true,
                        completeStruct = true,
                        completeUnion = true,
                        completeType = true,
                        extraIncludes = { "*.h" },
                    },
                },
            })

            -- Tailwind
            vim.lsp.config("tailwindcss", {
                filetypes = { "astro", "templ", "html", "javascriptreact", "typescriptreact", "svelte", "eruby" },
                root_markers = { "package.json", ".git" },
                init_options = { userLanguages = { templ = "html" } },
                settings = {
                    tailwindCSS = {
                        files = { exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" } },
                    },
                },
            })

            -- TSGO (Manual Custom Server)
            vim.lsp.config("tsgo", {
                cmd = { "tsgo", "--lsp", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "javascript.mjs",
                    "javascript.cjs",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "typescript.mts",
                    "typescript.cts",
                },
                root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
            })

            -- Filetype mapping
            vim.filetype.add({
                extension = { templ = "templ", razor = "razor", cshtml = "cshtml" },
            })

            -- 5. Enable Servers
            -- Finally, we enable the servers. 'nvim-lspconfig' (the library) will supply the
            -- default 'cmd', 'filetypes', etc., for standard servers, merging with our overrides above.

            -- Enable the standard list
            vim.lsp.enable(ensure_installed)

            -- Enable manual/extra servers
            vim.lsp.enable("tsgo")
        end,
    },
}
