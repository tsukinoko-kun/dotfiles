return {
    "olimorris/codecompanion.nvim",
    opts = {
        adapters = {
            gemini = function()
                return require("codecompanion.adapters").extend("gemini", {
                    env = {
                        api_key = os.getenv("GOOGLE_AI_API_KEY"),
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "gemini",
            },
            inline = {
                adapter = "gemini",
                keymaps = {
                    accept_change = {
                        modes = { n = "<leader>ga" },
                        description = "Accept the suggested change",
                    },
                    reject_change = {
                        modes = { n = "<leader>gr" },
                        description = "Reject the suggested change",
                    },
                },
            },
            cmd = {
                adapter = "gemini",
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
