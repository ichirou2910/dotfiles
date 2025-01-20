vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object"

vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

vim.opt.cmdheight = 0

vim.opt.wrap = false -- Display long lines as just one line
vim.opt.equalalways = false -- Prevent auto balance split size when split
vim.opt.mouse = "a" -- Enable your mouse

vim.opt.showtabline = 0

vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.ignorecase = true -- Ignore case, must use for smartcase to work
vim.opt.smartcase = true -- Smart case-insensitve/-sensitive search detection
vim.opt.expandtab = true -- Converts tabs to spaces

vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent

vim.opt.signcolumn = "yes"

vim.opt.laststatus = 3 -- Always display the status line

vim.opt.splitbelow = true -- set split below
vim.opt.splitright = true -- set split right

vim.opt.rnu = true
vim.opt.number = true -- Line numbers

vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like

vim.opt.shortmess:append("csI") -- Don't pass messages to |ins-completion-menu|.
vim.opt.updatetime = 300 -- Faster completion
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.splitkeep = "screen"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]

vim.g.bigfile_threshold = 2 * 1024 * 1024
