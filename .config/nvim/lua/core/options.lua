vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object"
vim.opt.sessionoptions:append("globals")

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.whichwrap:append("<>[]hl")
vim.opt.encoding = "utf-8" -- The encoding displayed
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 1 -- More space for displaying messages
vim.opt.equalalways = false -- Prevent auto balance split size when split
vim.opt.mouse = "a" -- Enable your mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.ignorecase = true -- Ignore case, must use for smartcase to work
vim.opt.smartcase = true -- Smart case-insensitve/-sensitive search detection
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.laststatus = 3 -- Always display the status line
vim.opt.rnu = true
vim.opt.list = true
vim.opt.number = true -- Line numbers
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.shortmess:append("csI") -- Don't pass messages to |ins-completion-menu|.
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.updatetime = 300 -- Faster completion
vim.opt.clipboard = { "unnamed", "unnamedplus" } -- Copy paste between vim and everything else
vim.opt.incsearch = true
vim.opt.switchbuf = { "useopen", "usetab" }
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.splitkeep = "screen"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.wrap = false

vim.opt.title = true
vim.opt.cul = true -- cursor line

vim.opt.timeoutlen = 500

vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]

-- Available themes, set blank to disable highlight system
vim.g.nv_theme = ""

-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
