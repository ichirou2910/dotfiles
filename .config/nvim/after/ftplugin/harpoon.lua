local harpoon = require("harpoon")

vim.keymap.set("n", "1", function()
    harpoon:list():select(1)
end, { buffer = true })
vim.keymap.set("n", "2", function()
    harpoon:list():select(2)
end, { buffer = true })
vim.keymap.set("n", "3", function()
    harpoon:list():select(3)
end, { buffer = true })
vim.keymap.set("n", "4", function()
    harpoon:list():select(4)
end, { buffer = true })
