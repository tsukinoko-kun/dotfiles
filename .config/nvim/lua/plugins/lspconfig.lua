-- enable keybinds only for when lsp server available
local on_attach_default = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end

    local function map(mode, lhs, rhs, opts)
        if rhs == nil then
            print("No rhs for " .. opts.desc)
            return
        end
        local options = {
            noremap = true,
            silent = true,
            buffer = bufnr,
        }
        if opts then
            options = vim.tbl_extend("force", options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
    end

    -- set keybinds
    map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" })
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Go to implementation" })
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Go to type definition" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Show code actions" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
    map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics for current line" })
    map("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show diagnostics for current buffer" })
    map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })

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
        map("n", "gs", vim.lsp.buf.definition, { desc = "Go to source definition" }) -- tsgo supports this natively
    end

    -- go specific keymaps (e.g. rename file and update imports)
    if client.name == "gopls" then
        require("core.format").set_format_on_save(true)
    end
end

return {
    {
        "mason-org/mason.nvim",
        config = true,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            -- list of servers for mason to install
            ensure_installed = {
                "astro", -- astro
                "svelte", -- svelte
                "gopls", -- go
                "templ", -- html templating
                "html", -- html
                "cssls", -- css, scss, less
                "tailwindcss", -- tailwind
                "lua_ls", -- lua
                "jsonls", -- json
                "marksman", -- markdown
                "yamlls", -- yaml
                "lemminx", -- xml
                "jdtls", -- java
                "biome", -- JS Linter
                "rust_analyzer", -- Rust
                "taplo", -- TOML
                "clangd", -- C/C++
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true,
            handlers = {
                -- default handler for all servers (applies common capabilities and on_attach)
                function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                    })
                end,
                -- custom overrides for specific servers (merge with common)
                ["gopls"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "go", "gomod", "gosum" },
                        settings = {
                            gopls = {
                                completeUnimported = true,
                                analyses = {
                                    unusedparams = true,
                                },
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
                end,
                ["templ"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "templ" },
                        root_dir = util.root_pattern("go.mod", ".git"),
                        settings = {
                            templ = {
                                files = {
                                    exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" },
                                },
                            },
                        },
                    })
                end,
                ["rust_analyzer"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "rust" },
                        root_dir = util.root_pattern("Cargo.toml"),
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
                end,
                ["taplo"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "toml" },
                        root_dir = util.root_pattern("go.mod", ".git"),
                        settings = {
                            taplo = {
                                format = {
                                    command = "taplo",
                                    args = { "format", "--check" },
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                        root_dir = function(fname)
                            return util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", ".ccls-root")(
                                fname
                            ) or util.root_pattern(".git")(fname) or vim.fs.dirname(fname)
                        end,
                        init_options = {
                            clangdFileStatus = true,
                            recurseGlob = true,
                            fallbackFlags = {
                                inherit = true,
                                warnings = {
                                    clang_tidy_checks = "*",
                                },
                            },
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
                end,
                ["tailwindcss"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = {
                            "astro",
                            "templ",
                            "html",
                            "javascriptreact",
                            "typescriptreact",
                            "svelte",
                            "eruby",
                        },
                        init_options = { userLanguages = { templ = "html" } },
                        settings = {
                            tailwindCSS = {
                                files = {
                                    exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" },
                                },
                            },
                        },
                    })
                end,
                ["ccls"] = function(server_name)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    local util = require("lspconfig.util")
                    require("mason-lspconfig").default_handler(server_name, {
                        capabilities = capabilities,
                        on_attach = on_attach_default,
                        filetypes = { "c", "cpp", "cc", "objc", "objcpp", "opencl" },
                        root_dir = function(fname)
                            return util.root_pattern(".git", "WORKSPACE", "WORKSPACE.bazel", ".cmake", "CMakeLists.txt")(
                                fname
                            ) or vim.fs.dirname(
                                vim.fs.find(".git", { path = fname, upward = true })[1]
                            )
                        end,
                        init_options = {
                            cache = {
                                directory = ".ccls-cache",
                            },
                        },
                    })
                end,
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "mason-org/mason-lspconfig.nvim",
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            vim.filetype.add({
                extension = { templ = "templ", razor = "razor", cshtml = "cshtml" },
            })
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Manually configure tsgo since it's not managed by mason
            -- This assumes `tsgo` is in your PATH
            vim.lsp.config("tsgo", {
                cmd = { "tsgo", "--lsp", "--stdio" },
                on_attach = on_attach_default,
                capabilities = require("blink.cmp").get_lsp_capabilities(),
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
            vim.lsp.enable("tsgo")
        end,
    },
}
