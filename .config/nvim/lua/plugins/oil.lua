return {
    "stevearc/oil.nvim",
    opts = {
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
            "icon",
            -- "permissions",
            -- "size",
            -- "mtime",
        },
        lsp_file_methods = {
            -- Enable or disable LSP file operations
            enabled = true,
            -- Time to wait for LSP file operations to complete before skipping
            timeout_ms = 1000,
            -- Set to true to autosave buffers that are updated with LSP willRenameFiles
            -- Set to "unmodified" to only save unmodified buffers
            autosave_changes = false,
        },
        watch_for_changes = false,
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },
        default_file_explorer = true,
        restore_win_options = true,
        skip_confirm_for_simple_edits = true,
        delete_to_trash = false,
        keymaps = {
            ["<leader>?"] = "actions.show_help",
            ["<leader>."] = "actions.toggle_hidden",
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
    lazy = false,
}
