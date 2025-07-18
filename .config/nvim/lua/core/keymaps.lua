local map = require("utils").map

vim.g.clipboard = {
    name = "macOS clipboard",
    copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
    },
    paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
    },
    cache_enabled = 0,
}

map(
    { "n", "v" },
    "<Up>",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, noremap = true, desc = "Move up (smart)" }
)
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true, desc = "Move up (smart)" })

map(
    { "n", "v" },
    "<Down>",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, noremap = true, desc = "Move down (smart)" }
)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true, desc = "Move down (smart)" })

-- remove highlight on escape (additionally to default <esc> behaviour)
map("n", "<esc>", "<cmd>noh<cr><esc>")

map({ "n", "i", "v" }, "<C-s>", "<cmd>wa<CR>", {
    desc = "Write all buffers",
})
map({ "n", "i" }, "<C-q>", "<cmd>q<CR>", {
    desc = "Quit all buffers",
})

map("v", "d", '"_x"<esc>', {
    desc = "Delete without yanking",
})
map("n", "dd", '"_dd', {
    desc = "Delete line without yanking",
})
map("n", "D", '"_d$', {
    desc = "Delete to end of line without yanking",
})
map("n", "Y", '"_y$', {
    desc = "Yank to end of line",
})
map("n", "Y", '"_y$"_d$', {
    desc = "Yank to end of line and delete to end of line",
})
map("n", "xx", "dd", {
    desc = "Yank whole line and delete it",
})
map("n", "X", "D", {
    desc = "Yank whole line and delete it",
})

map("n", "x$", "d$", {
    desc = "Cut out to end of line",
})
map("n", "x%", "d%", {
    desc = "Cut out to matching bracket",
})
map("n", "x0", "d0", {
    desc = "Cut out to beginning of line",
})
map("n", "x^", "d^", {
    desc = "Cut out to first non-blank character",
})
map("n", "x{", "d{", {
    desc = "Cut out to beginning of paragraph",
})
map("n", "x}", "d}", {
    desc = "Cut out to end of paragraph",
})
map("n", "xb", "db", {
    desc = "Cut out to previous word",
})
map("n", "xe", "de", {
    desc = "Cut out to next word",
})
map("n", "xF", "dF", {
    desc = "Cut out to previous character",
})
map("n", "xf", "df", {
    desc = "Cut out to next character",
})
map("n", "xG", "dG", {
    desc = "Cut out to end of file",
})
map("n", "xh", "dh", {
    desc = "Cut out to left",
})
map("n", "xj", "dj", {
    desc = "Cut out down",
})
map("n", "xk", "dk", {
    desc = "Cut out up",
})
map("n", "xl", "dl", {
    desc = "Cut out to right",
})
map("n", "xT", "dT", {
    desc = "Cut out to previous character",
})
map("n", "xt", "dt", {
    desc = "Cut out to next character",
})
map("n", "xw", "dw", {
    desc = "Cut out to next word",
})
map("n", "x[", "d[", {
    desc = "Cut out to previous section",
})
map("n", "x]", "d]", {
    desc = "Cut out to next section",
})
map("n", "xaw", "daw", {
    desc = "Cut out around word",
})
map("n", "xap", "dap", {
    desc = "Cut out around paragraph",
})
map("n", "xa{", "da{", {
    desc = "Cut out around curly braces",
})
map("n", "xa[", "da[", {
    desc = "Cut out around square brackets",
})
map("n", "xa(", "da(", {
    desc = "Cut out around parentheses",
})
map("n", 'xa"', 'da"', {
    desc = "Cut out around double quotes",
})
map("n", "xa'", "da'", {
    desc = "Cut out around single quotes",
})
map("n", "xa<", "da<", {
    desc = "Cut out around angle brackets",
})
map("n", "xg", "dg", {
    desc = "Cut out to last change",
})
map("n", "xiw", "diw", {
    desc = "Cut out to inside word",
})
map("n", "xip", "dip", {
    desc = "Cut out to inside paragraph",
})
map("n", "xi{", "di{", {
    desc = "Cut out to inside curly braces",
})
map("n", "xi[", "di[", {
    desc = "Cut out to inside square brackets",
})
map("n", "xi(", "di(", {
    desc = "Cut out to inside parentheses",
})
map("n", 'xi"', 'di"', {
    desc = "Cut out to inside double quotes",
})
map("n", "xi'", "di'", {
    desc = "Cut out to inside single quotes",
})
map("n", "xi<", "di<", {
    desc = "Cut out to inside angle brackets",
})

-- stop p from yanking selected text
vim.keymap.set("v", "p", '"_dP')

-- stop c from yanking
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_c$')
vim.keymap.set("v", "c", '"_c')
vim.keymap.set("v", "C", '"_c$')
vim.keymap.set("n", "c$", '"_c$')
vim.keymap.set("n", "c%", '"_c%')
vim.keymap.set("n", "c0", '"_c0')
vim.keymap.set("n", "c^", '"_c^')
vim.keymap.set("n", "c{", '"_c{')
vim.keymap.set("n", "c}", '"_c}')
vim.keymap.set("n", "cb", '"_cb')
vim.keymap.set("n", "ce", '"_ce')
vim.keymap.set("n", "cF", '"_cF')
vim.keymap.set("n", "cf", '"_cf')
vim.keymap.set("n", "cG", '"_cG')
vim.keymap.set("n", "ch", '"_ch')
vim.keymap.set("n", "cj", '"_cj')
vim.keymap.set("n", "ck", '"_ck')
vim.keymap.set("n", "cl", '"_cl')
vim.keymap.set("n", "cT", '"_cT')
vim.keymap.set("n", "ct", '"_ct')
vim.keymap.set("n", "cw", '"_cw')
vim.keymap.set("n", "c[", '"_c[')
vim.keymap.set("n", "c]", '"_c]')
vim.keymap.set("n", "ca", '"_ca')
vim.keymap.set("n", "cg", '"_cg')
vim.keymap.set("n", "ci", '"_ci')

-- stop d from yanking
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "D", '"_d$')
vim.keymap.set("v", "d", '"_d')
vim.keymap.set("v", "D", '"_d$')
vim.keymap.set("n", "d$", '"_d$')
vim.keymap.set("n", "d%", '"_d%')
vim.keymap.set("n", "d0", '"_d0')
vim.keymap.set("n", "d^", '"_d^')
vim.keymap.set("n", "d{", '"_d{')
vim.keymap.set("n", "d}", '"_d}')
vim.keymap.set("n", "db", '"_db')
vim.keymap.set("n", "de", '"_de')
vim.keymap.set("n", "dF", '"_dF')
vim.keymap.set("n", "df", '"_df')
vim.keymap.set("n", "dG", '"_dG')
vim.keymap.set("n", "dh", '"_dh')
vim.keymap.set("n", "dj", '"_dj')
vim.keymap.set("n", "dk", '"_dk')
vim.keymap.set("n", "dl", '"_dl')
vim.keymap.set("n", "dT", '"_dT')
vim.keymap.set("n", "dt", '"_dt')
vim.keymap.set("n", "dw", '"_dw')
vim.keymap.set("n", "d[", '"_d[')
vim.keymap.set("n", "d]", '"_d]')
vim.keymap.set("n", "da", '"_da')
vim.keymap.set("n", "dg", '"_dg')
vim.keymap.set("n", "di", '"_di')

-- tabs
map("n", "<c-t>", "<cmd>tabnew<cr>", {
    desc = "New tab",
})
map("n", "<c-1>", ":tabn 1<CR>", {
    desc = "Tab 1",
})
map("n", "<c-2>", ":tabn 2<CR>", {
    desc = "Tab 2",
})
map("n", "<c-3>", ":tabn 3<CR>", {
    desc = "Tab 3",
})
map("n", "<c-4>", ":tabn 4<CR>", {
    desc = "Tab 4",
})
map("n", "<c-5>", ":tabn 5<CR>", {
    desc = "Tab 5",
})
map("n", "<c-6>", ":tabn 6<CR>", {
    desc = "Tab 6",
})
map("n", "<c-7>", ":tabn 7<CR>", {
    desc = "Tab 7",
})
map("n", "<c-8>", ":tabn 8<CR>", {
    desc = "Tab 8",
})
map("n", "<c-9>", ":tabn 9<CR>", {
    desc = "Tab 9",
})
map("n", "<c-0>", ":tabn 10<CR>", {
    desc = "Tab 10",
})
map("n", "<c-w>", "<cmd>tabclose<cr>", {
    desc = "Close tab",
})

-- explorer
map("n", "-", require("oil").open, { desc = "Open parent directory" })
map("n", "<leader>T", require("trouble").toggle, { desc = "Toggle trouble list" })

-- git
map("n", "<leader>fg", require("telescope").extensions.git_worktree.git_worktrees, {
    desc = "Fuzzy search git worktrees",
})
map("n", "<leader>fG", require("telescope").extensions.git_worktree.create_git_worktree, {
    desc = "Create git worktree",
})
map("n", "<leader>gg", "<cmd>LazyGit<CR>", {
    desc = "LazyGit",
})
map("n", "<leader>gp", "<cmd>Git stash<CR><cmd>Git pull<CR><cmd>Git stash pop<CR>", {
    desc = "Git pull",
})
map("n", "<leader>gb", "<cmd>Git branch<CR>", {
    desc = "Git branch",
})
map("n", "<leader>gL", function()
    require("gitsigns").toggle_linehl()
    require("gitsigns").toggle_word_diff()
    require("gitsigns").toggle_deleted()
end, {
    desc = "Git lens",
})
map("n", "<leader>gsb", "<cmd>Gitsigns stage_buffer<CR>", {
    desc = "Git stage buffer",
})
map("n", "<leader>gsB", "<cmd>Gitsigns reset_hunk<CR>", {
    desc = "Git unstage buffer",
})
map("n", "<leader>gsh", "<cmd>Gitsigns stage_hunk<CR>", {
    desc = "Git stage hunk",
})
map("n", "<leader>gsH", "<cmd>Gitsigns undo_stage_hunk<CR>", {
    desc = "Git unstage hunk",
})
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", {
    desc = "Git diff",
})
map("n", "<leader>gl", "<cmd>Git log<CR>", {
    desc = "Git log",
})

-- telescope
map("n", "<leader>ff", require("telescope.builtin").find_files, {
    desc = "Fuzzy search files",
})
map("n", "<leader>fs", function()
    local opts = { cwd = vim.uv.cwd() }
    local finder = require("telescope.finders").new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end
            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end
            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end
            return vim.tbl_flatten({
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            })
        end,
        entry_maker = require("telescope.make_entry").gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })
    require("telescope.pickers")
        .new(opts, {
            debounce = 200,
            prompt_title = "Multi Grep",
            finder = finder,
            previewer = require("telescope.config").values.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end, { desc = "multi grep" })
map("n", "<leader>fc", require("telescope.builtin").grep_string, {
    desc = "grep find in files",
})
map("n", "<leader>fb", function()
    require("telescope.builtin").current_buffer_fuzzy_find({ sorting_strategy = "ascending", prompt_position = "top" })
end, {
    desc = "Fuzzy search current buffer",
})
map("n", "<leader>fB", require("telescope.builtin").buffers, {
    desc = "Fuzzy search buffers",
})
map("n", "<leader>fh", require("telescope.builtin").help_tags, {
    desc = "Fuzzy search help tags",
})
map("n", "<leader>p", "<cmd>Telescope neoclip<cr>", {
    desc = "Fuzzy search clipboard history",
})
map("n", "<leader>z", "<cmd>Telescope zoxide list<cr>", {
    desc = "Fuzzy search zoxide history",
})
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {
    desc = "Hover",
})
map("n", "<leader>lco", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>", {
    desc = "Hover",
})
map("n", "<leader>lci", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>", {
    desc = "Hover",
})

-- indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ect
map("n", "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>", {
    desc = "Toggle undo tree",
})
-- map("n", "gK", require("hover").hover_select, { desc = "Hover select" })
map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {
    desc = "Toggle inlay hints",
})

-- harpoon
map("n", "<leader>hh", "<cmd>Telescope harpoon marks<cr>", {
    desc = "Fuzzy search Harpoon marks",
})
map("n", "<leader>hc", "<cmd>lua require('harpoon'):list():clear()<cr>", {
    desc = "Clear all Harpoon marks",
})
map("n", "<leader>ha", "<cmd>lua require('harpoon'):list():add()<cr>", {
    desc = "Add file to Harpoon",
})
map("n", "<leader>hj", '<cmd>lua require("harpoon"):list():next()<cr>', {
    desc = "Navigate to next Harpoon mark",
})
map("n", "<leader>hk", '<cmd>lua require("harpoon.ui"):list():prev()<cr>', {
    desc = "Navigate to previous Harpoon mark",
})
map("n", "<leader>h1", '<cmd>lua require("harpoon"):list():select(1)<cr>', {
    desc = "Navigate to Harpoon mark 1",
})
map("n", "<leader>h2", '<cmd>lua require("harpoon"):list():select(2)<cr>', {
    desc = "Navigate to Harpoon mark 2",
})
map("n", "<leader>h3", '<cmd>lua require("harpoon"):list():select(3)<cr>', {
    desc = "Navigate to Harpoon mark 3",
})
map("n", "<leader>h4", '<cmd>lua require("harpoon"):list():select(4)<cr>', {
    desc = "Navigate to Harpoon mark 4",
})
map("n", "<leader>h5", '<cmd>lua require("harpoon"):list():select(5)<cr>', {
    desc = "Navigate to Harpoon mark 5",
})
map("n", "<leader>h6", '<cmd>lua require("harpoon"):list():select(6)<cr>', {
    desc = "Navigate to Harpoon mark 6",
})
map("n", "<leader>h7", '<cmd>lua require("harpoon"):list():select(7)<cr>', {
    desc = "Navigate to Harpoon mark 7",
})
map("n", "<leader>h8", '<cmd>lua require("harpoon"):list():select(8)<cr>', {
    desc = "Navigate to Harpoon mark 8",
})
map("n", "<leader>h9", '<cmd>lua require("harpoon"):list():select(9)<cr>', {
    desc = "Navigate to Harpoon mark 9",
})

-- window
map("n", "<leader>m", "<cmd>Glow<CR>", {
    desc = "Markdown preview",
})
map("n", '<c-w>"', "<cmd>split<CR>", {
    desc = "Split window horizontally",
})
map("n", "<c-w>%", "<cmd>vsplit<CR>", {
    desc = "Split window vertically",
})

-- Format
map({ "n", "v" }, "<leader>F", function()
    local conform = require("conform")
    pcall(conform.format, {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
    })
end, {
    desc = "Format buffer",
})

-- Lint
map("n", "<leader>L", function()
    require("lint").try_lint()
end, {
    desc = "Lint buffer",
})

-- Prime
map("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selected line down",
})
map("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selected line up",
})
map("n", "J", "mzJ`z", {
    desc = "Move current line down",
})
map("n", "<C-d>", "<C-d>zz", {
    desc = "Scroll down",
})
map("n", "<C-u>", "<C-u>zz", {
    desc = "Scroll up",
})
map("n", "<C-J>", ":cnext<CR>", {
    desc = "Next quickfix list item",
})
map("n", "<C-K>", ":cprevious<CR>", {
    desc = "Previous quickfix list item",
})

-- spellcheck
map("n", "<leader>ct", function()
    vim.opt.spell = not vim.opt.spell
end, {
    desc = "Toggle spellcheck",
})
map("n", "<leader>cd", function()
    require("telescope.builtin").spell_suggest()
end, {
    desc = "Select spellcheck suggestion",
})
-- use telescope to select language
map("n", "<leader>cl", function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    local opts = {
        prompt_title = "Select Spellcheck Language",
        finder = finders.new_table({
            results = { "en_us", "de_de" },
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.opt.spelllang = selection[1]
                print("Spellcheck language set to: " .. selection[1])
            end)
            return true
        end,
    }
    pickers.new({}, opts):find()
end, {
    desc = "Select spellcheck language",
})
