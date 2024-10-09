return {
    {
        "echasnovski/mini.icons",
        opts = {},
        lazy = true,
        init = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end,
    },
}
