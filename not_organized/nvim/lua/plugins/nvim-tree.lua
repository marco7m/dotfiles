local nvim_tree = require("nvim-tree")

require("nvim-web-devicons").setup()

require("nvim-tree").setup({
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = true
})
-- nvim_tree.setup({
-- })

vim.keymap.set('n', '<C-n>',
  function()
    return require('nvim-tree.api').tree.toggle(false, false)
  end,
  { noremap = true, silent = true, desc = "toggle nvim-tree"})

vim.cmd([[ 
  set termguicolors 
]])
