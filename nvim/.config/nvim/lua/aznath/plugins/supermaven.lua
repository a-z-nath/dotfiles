return {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-y>",
                clear_suggesiton = "<C-h>", -- clear the suggestion on backspace
                accept_word = "<C-j>",
            },
            ignore_filetypes = {
                "TelescopePrompt",
                "oil",
                "snacks_picker_input",
                "neorg",
            },
            color = {
                suggestion_color = "#ffffff",
                cterm = 244,
            },
            log_level = "off",
        })
    end,
}
