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

    -- typescript specific keymaps (e.g. rename file and update imports)
    if client.name == "typescript-tools" then
        map("n", "<leader>lrf", ":TSToolsRenameFile<CR>", { desc = "Rename file and update imports" })
        map("n", "<leader>loi", ":TSToolsOrganizeImports<CR>", { desc = "Organize imports" })
        map("n", "<leader>lru", ":TSToolsRemoveUnused<CR>", { desc = "Remove unused imports" })
        map("n", "gs", ":TSToolsGoToSourceDefinition<CR>", { desc = "Go to source definition" })
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
            automatic_enable = false,
            -- list of servers for mason to install
            ensure_installed = {
                "astro", -- astro
                "svelte", -- svelte
                "gopls", -- go
                "templ", -- html templating
                "htmx", -- htmx
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
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as :ensure_installed
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
            local lspconfig = require("lspconfig")
            vim.filetype.add({
                extension = { templ = "templ", razor = "razor", cshtml = "cshtml" },
            })
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach_default })
            lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = on_attach_default,
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
            lspconfig.templ.setup({
                capabilities = capabilities,
                on_attach = on_attach_default,
                filetypes = { "templ", "go" },
                root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
                settings = {
                    templ = {
                        files = {
                            exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" },
                        },
                    },
                },
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                on_attach = on_attach_default,
                filetypes = { "astro", "templ", "html", "javascriptreact", "typescriptreact", "svelte", "eruby" },
                init_options = { userLanguages = { templ = "html" } },
                settings = {
                    tailwindCSS = {
                        files = {
                            exclude = { "node_modules", ".git", "dist", "build", ".cache", ".next" },
                        },
                    },
                },
            })
            lspconfig.ccls.setup({
                filetypes = { "c", "cpp", "cc", "objc", "objcpp", "opencl" },
                root_dir = function(fname)
                    local util = require("lspconfig.util")
                    return util.root_pattern(".git", "WORKSPACE", "WORKSPACE.bazel", ".cmake", "CMakeLists.txt")(fname)
                        or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
                end,
                init_options = {
                    cache = {
                        directory = ".ccls-cache",
                    },
                },
                capabilities = capabilities,
                on_attach = on_attach_default,
            })
        end,
    },

    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            on_attach = on_attach_default,
            root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern(
                    "tsconfig.json",
                    "turbo.json",
                    "docker-compose.yml",
                    ".eslintrc.cjs",
                    "pnpm-workspace.yaml",
                    "pnpm-lock.yaml"
                )(fname) or util.root_pattern("package.json", ".git")(fname) or util.find_git_ancestor(
                    fname
                )
            end,
            settings = {
                publish_diagnostic_on = "change",
                tsserver_locale = "en",
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true,
                    quotePreference = "auto",
                },
                tsserver_format_options = {
                    allowIncompleteCompletions = false,
                    allowRenameOfImportPath = false,
                },
            },
        },
    },
}
