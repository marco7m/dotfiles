return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
        })

        -- Mapeamento de tecla
        vim.keymap.set('n', '<C-n>',
            function()
                require('nvim-tree.api').tree.toggle(false, false)
            end,
            { noremap = true, silent = true, desc = "Toggle NvimTree" }
        )

        -- termguicolors is now set in lua/config/options.lua
    end
}
