local map = vim.keymap.set

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP')

-- Buffer
map("n", "<A-.>", ":bnext<CR>")
map("n", "<A-,>", ":bprev<CR>")

map("n", "<A->>", ":BufferMoveNext<CR>")
map("n", "<A-<>", ":BufferMovePrevious<CR>")

map("n", "<leader>q", ":bdelete<CR>", { desc = "Delete Buffer" })

-- Block movement
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Search navigation
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<leader>n", ":noh<CR>", { desc = "No Highlight" })

-- Window nav
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
map("n", "<M-h>", "<c-w>5<")
map("n", "<M-j>", "<c-w>-")
map("n", "<M-k>", "<c-w>+")
map("n", "<M-l>", "<c-w>5>")

map("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true })

-- Explorer
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Explorer" })

-- Git
map("n", "<leader>ga", "<cmd>Git add %<CR>", { desc = "Git Add current file" })
map("n", "<leader>gA", "<cmd>Git add .<CR>", { desc = "Git Add all files" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git Commit" })
map("n", "<leader>gf", "<cmd>Git fetch<CR>", { desc = "Git Fetch" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git Push" })
map("n", "<leader>gP", "<cmd>Git pull<CR>", { desc = "Git Pull" })
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git Status" })
map("n", "<leader>gr", "<cmd>GRemove<CR>", { desc = "Git Remove" })
map("n", "<leader>gx", "<cmd>Git restore %<CR>", { desc = "Git Restore current file" })
map("n", "<leader>ug", MiniDiff.toggle_overlay, { desc = "Toggle Diff Overlay" })

-- Treesitter
map("n", "gs", function() require("treesitter-context").go_to_context(vim.v.count1) end, { desc = "Go to sticky scroll" })
