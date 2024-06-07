-- Notification
return {
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                render = "wrapped-compact",
                stages = "static",

                timeout = 3000,

                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "",
                },
                animate = false,
            })
        end,
    },
}
