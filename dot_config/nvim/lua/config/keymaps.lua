-- Keymaps migrated from vimscript_config.lua + lua/mappings.lua

local map = vim.keymap.set

-- Diagnostics
map("n", "<C-k>", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "diagnostico de linha" })

-- Search highlight
map("n", "<F8>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "turn search highlight off" })
map("n", "#", "#:nohlsearch<CR>", { noremap = true, silent = true, desc = "search word backward and clear highlight" })
map("n", "<F1>", function()
    local ok, snacks = pcall(require, "snacks")
    if ok and snacks and snacks.picker then
        snacks.picker.keymaps()
        return
    end
    vim.notify("Snacks picker not available", vim.log.levels.WARN)
end, { noremap = true, silent = true, desc = "open keymaps picker" })

-- Insert mode escape
map("i", "jk", "<Esc>", { noremap = true, desc = "sair do insert mode com jk" })
map("i", "JK", "<Esc>", { noremap = true, desc = "sair do insert mode com JK" })

-- Command-line
map("n", ";", ":", { noremap = true, desc = "enter command-line (alternative to :)" })
map("n", "<Space>", ":", { noremap = true, desc = "enter command-line (:) with space" })

-- Legacy picker aliases (old Telescope muscle memory)
map("n", "<Space><Space>", function()
    require("snacks").picker.smart()
end, { noremap = true, silent = true, desc = "smart find files (legacy)" })

map("n", "<Space>/", function()
    require("snacks").picker.grep()
end, { noremap = true, silent = true, desc = "grep (legacy)" })

map("n", "<leader>f?", function()
    vim.notify(
        table.concat({
            "Find aliases:",
            "\\ff files",
            "\\fg grep",
            "\\fG git files",
            "\\fb buffers",
            "\\fh help",
            "\\fs symbols",
            "\\fw word/selection grep",
            "Tip: press F1 and filter by \\\\f",
        }, "\n"),
        vim.log.levels.INFO,
        { title = "Find Keymaps" }
    )
end, { noremap = true, silent = true, desc = "show find aliases cheat sheet" })

map("n", "gR", function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if ok and builtin and builtin.lsp_references then
        builtin.lsp_references()
        return
    end
    vim.notify("Telescope is not available", vim.log.levels.WARN)
end, { noremap = true, silent = true, desc = "References (Telescope)" })

-- Window navigation (Alt+h/j/k/l)
map("n", "<M-l>", "<C-w>l", { noremap = true, silent = true, desc = "movimentação entre windows" })
map("n", "<M-j>", "<C-w>j", { noremap = true, silent = true, desc = "movimentação entre windows" })
map("n", "<M-h>", "<C-w>h", { noremap = true, silent = true, desc = "movimentação entre windows" })
map("n", "<M-k>", "<C-w>k", { noremap = true, silent = true, desc = "movimentação entre windows" })

map("t", "<M-l>", "<C-\\><C-n><C-w>l", { noremap = true, silent = true, desc = "movimentação entre windows (terminal)" })
map("t", "<M-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true, desc = "movimentação entre windows (terminal)" })
map("t", "<M-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true, desc = "movimentação entre windows (terminal)" })
map("t", "<M-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true, desc = "movimentação entre windows (terminal)" })

-- Tab navigation (Alt+u / Alt+i)
map("n", "<M-u>", "<cmd>tabprevious<CR>", { noremap = true, silent = true, desc = "tab previous" })
map("n", "<M-o>", "<cmd>tabnext<CR>", { noremap = true, silent = true, desc = "tab next" })
map("i", "<M-u>", "<Esc><cmd>tabprevious<CR>", { noremap = true, silent = true, desc = "tab previous" })
map("i", "<M-o>", "<Esc><cmd>tabnext<CR>", { noremap = true, silent = true, desc = "tab next" })
map("t", "<M-u>", "<C-\\><C-n><cmd>tabprevious<CR>", { noremap = true, silent = true, desc = "tab previous (terminal)" })
map("t", "<M-o>", "<C-\\><C-n><cmd>tabnext<CR>", { noremap = true, silent = true, desc = "tab next (terminal)" })

-- Resize splits with arrow keys
map("n", "<Left>", "<C-w><", { noremap = true, silent = true, desc = "resize window left" })
map("n", "<Right>", "<C-w>>", { noremap = true, silent = true, desc = "resize window right" })
map("n", "<Up>", "<C-w>+", { noremap = true, silent = true, desc = "resize window up" })
map("n", "<Down>", "<C-w>-", { noremap = true, silent = true, desc = "resize window down" })

-- Insert helpers
map("i", "{<CR>", "{<Enter>}<Esc>ko", { noremap = true, desc = "autocomplete de chaves" })
map("i", "[", "[", { noremap = true, desc = "tira o autocomplete dos colchetes" })
map("n", "<CR>", "i<CR><Esc>", { noremap = true, silent = true, desc = "insere uma nova linha" })

-- NOTE: Removed the old C/C++ header/source switch on <F4>
-- to keep <F4> for LSP code actions (defined in lsp-config.lua).

-- CSCOPE keymaps (kept, but guarded with a helpful message)
local function cscope_find(kind, query)
    if vim.fn.has("cscope") ~= 1 then
        vim.notify("cscope não está disponível nesta build do Neovim", vim.log.levels.WARN)
        return
    end
    vim.cmd(("cs find %s %s"):format(kind, query))
end

map("n", "<C-]>s", function()
    cscope_find("s", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: find C symbol" })

map("n", "<C-]>g", function()
    cscope_find("g", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: find definition" })

map("n", "<C-]>c", function()
    cscope_find("c", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: find functions calling this" })

map("n", "<C-]>t", function()
    cscope_find("t", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: find text string" })

map("n", "<C-]>e", function()
    cscope_find("e", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: egrep pattern" })

map("n", "<C-]>f", function()
    cscope_find("f", vim.fn.expand("<cfile>"))
end, { noremap = true, silent = true, desc = "cscope: find file" })

map("n", "<C-]>i", function()
    cscope_find("i", "^" .. vim.fn.expand("<cfile>") .. "$")
end, { noremap = true, silent = true, desc = "cscope: find files including this file" })

map("n", "<C-]>d", function()
    cscope_find("d", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: functions called by this function" })

map("n", "<C-]>a", function()
    cscope_find("a", vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "cscope: places where symbol assigned" })
