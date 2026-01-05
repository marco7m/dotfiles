-- Core editor options migrated from vimscript_config.lua

-- Backspace like a modern editor
vim.opt.backspace = { "indent", "eol", "start" }

-- Search
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- UI
vim.opt.showmode = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.scrolloff = 6
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.laststatus = 2
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Tabs/indent
vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Comments (kept from vimscript)
-- vim.opt.comments = "sl:/*,mb:\\ *,elx:\\ */"

-- Rust fmt autosave (kept from vimscript)
vim.g.rustfmt_autosave = 1

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable filetype + indentation plugins (kept explicit)
vim.cmd("filetype plugin indent on")
