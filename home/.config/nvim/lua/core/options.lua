local opt = vim.opt

opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event

vim.o.completeopt = "menuone,noinsert,noselect"
vim.wo.signcolumn = "yes"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd("set nofoldenable")
vim.cmd("set showcmd")

-- disable mouse
-- opt.mouse = ""

-- spell check
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- timeout
opt.timeoutlen = 500
opt.timeout = true

-- line numbers
opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = true

-- search
opt.ignorecase = true
opt.smartcase = true
vim.cmd("set rtp+=/opt/homebrew/opt/fzf")

-- cursor line
opt.cursorline = true
opt.cursorcolumn = true

-- scrolloff
opt.scrolloff = 8

-- appearance
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false
opt.termguicolors = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append({ "unnamed", "unnamedplus" })

-- split windows
opt.splitright = true
opt.splitbelow = true

-- keywords
opt.iskeyword:append("_")
