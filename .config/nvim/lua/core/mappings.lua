local keymap = require("core.utils").keymap
local toggle = require("core.utils").toggle_vim_opt

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Don't copy the replaced text after pasting in visual mode
keymap("v", "p", '"_dP')

-- Buffer
keymap("n", "<A-.>", ":bnext<CR>")
keymap("n", "<A-,>", ":bprev<CR>")

keymap("n", "<A-1>", ":BufferGoto 1<CR>")
keymap("n", "<A-2>", ":BufferGoto 2<CR>")
keymap("n", "<A-3>", ":BufferGoto 3<CR>")
keymap("n", "<A-4>", ":BufferGoto 4<CR>")
keymap("n", "<A-5>", ":BufferGoto 5<CR>")
keymap("n", "<A-6>", ":BufferGoto 6<CR>")
keymap("n", "<A-7>", ":BufferGoto 7<CR>")
keymap("n", "<A-8>", ":BufferGoto 8<CR>")
keymap("n", "<A-9>", ":BufferGoto 9<CR>")
keymap("n", "<A-0>", ":BufferLast<CR>")

keymap("n", "<A->>", ":BufferMoveNext<CR>")
keymap("n", "<A-<>", ":BufferMovePrevious<CR>")

-- Block movement
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Search navigation
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Undo breakpoints
keymap("i", "[", "[<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ",", ",<c-g>u")
keymap("i", "{", "{<c-g>u")

-- Window nav
keymap("n", "<c-h>", "<c-w>h")
keymap("n", "<c-j>", "<c-w>j")
keymap("n", "<c-k>", "<c-w>k")
keymap("n", "<c-l>", "<c-w>l")
keymap("n", "<M-h>", "<c-w>5<")
keymap("n", "<M-j>", "<c-w>-")
keymap("n", "<M-k>", "<c-w>+")
keymap("n", "<M-l>", "<c-w>5>")

-- Use control-c instead of escape
keymap("n", "<C-c>", "<Esc>")

keymap("n", "<c-q>", ":BufferClose<CR>")

keymap("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
keymap("n", "k", "v:count ? 'k' : 'gk'", { expr = true })
keymap("n", "<Down>", "v:count ? 'j' : 'gj'", { expr = true })
keymap("n", "<Up>", "v:count ? 'k' : 'gk'", { expr = true })

-- turn off search highlighting
keymap("n", "<C-n>", ":noh <CR>")

-- you can't stop me!
keymap("c", "w!!", "w !sudo tee %")
keymap("c", "ww", "noa w")

-- jumping
keymap("n", "<A-[>", "<C-o>")
keymap("n", "<A-]>", "<C-i>")

vim.keymap.set("n", "<leader>uw", function()
    toggle("wrap", { global = true })
end, { desc = "Toggle line wrap" })
vim.keymap.set("n", "<leader>ul", function()
    toggle("relativenumber", { global = true })
end, { desc = "Toggle relative line numbers" })
