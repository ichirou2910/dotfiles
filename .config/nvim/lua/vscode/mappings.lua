local keymap = require("core.utils").keymap

keymap("n", "gn", "<cmd>lua require('vscode-neovim').call('editor.action.marker.next')<CR>")
keymap("n", "gp", "<cmd>lua require('vscode-neovim').call('editor.action.marker.prev')<CR>")
