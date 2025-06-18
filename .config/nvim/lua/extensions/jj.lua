local function jj_describe()
    vim.cmd.vsplit()
    vim.cmd.terminal()
    vim.api.nvim_chan_send(vim.bo.channel, "clear ; jj describe ; exit\r")
    vim.api.nvim_feedkeys("a", "t", false)
end

local function jj_new()
    vim.fn.jobstart("jj new")
end

local function jj_push()
    vim.fn.jobstart("jj git push")
end

local function jj_fetch()
    vim.fn.jobstart("jj git fetch")
end

local map = require("utils").map

map("n", "<leader>jd", jj_describe, { desc = "JJ describe" })
map("n", "<leader>jn", jj_new, { desc = "JJ new" })
map("n", "<leader>jp", jj_push, { desc = "JJ push" })
map("n", "<leader>jf", jj_fetch, { desc = "JJ fetch" })
