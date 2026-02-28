return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        cmd = { "RenderMarkdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            { "echasnovski/mini.icons", opts = {} },
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            file_types = { "markdown" },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)

            local function set_toggle_key(bufnr)
                vim.keymap.set("n", "<F9>", function()
                    require("render-markdown").buf_toggle()
                end, {
                    buffer = bufnr,
                    silent = true,
                    desc = "toggle rendered markdown",
                })
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(args)
                    set_toggle_key(args.buf)
                end,
            })

            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.bo[bufnr].filetype == "markdown" then
                    set_toggle_key(bufnr)
                end
            end
        end,
    },
}
