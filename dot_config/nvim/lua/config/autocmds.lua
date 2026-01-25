-- Autocommands migrated from lua/mappings.lua + vimscript_config.lua

-- Enable syntax highlighting (kept explicit)
vim.cmd("syntax enable")

-- Python: open glow in a vsplit terminal
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function(ev)
        vim.keymap.set(
            "n",
            "<F9>",
            ":vs term://glow %<CR>",
            { buffer = ev.buf, noremap = true, silent = true, desc = "open glow on a vsplit tab" }
        )
    end,
})

-- Markdown: toggle preview with F9
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(ev)
        vim.keymap.set(
            "n",
            "<F9>",
            "<cmd>MarkdownPreviewToggle<CR>",
            { buffer = ev.buf, noremap = true, silent = true, desc = "toggle markdown preview" }
        )
    end,
})

-- CSCOPE setup (kept from vimscript)
if vim.fn.has("cscope") == 1 then
    vim.o.csprg = "/usr/bin/cscope"
    vim.o.csto = 0
    vim.o.cst = true

    vim.cmd("set nocsverb")
    if vim.fn.filereadable("cscope.out") == 1 then
        vim.cmd("cs add cscope.out")
    elseif (vim.env.CSCOPE_DB or "") ~= "" then
        vim.cmd("cs add " .. vim.env.CSCOPE_DB)
    end
    vim.cmd("set csverb")
end


