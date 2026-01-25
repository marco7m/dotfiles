-- Autocommands migrated from lua/mappings.lua + vimscript_config.lua

-- Enable syntax highlighting (kept explicit)
vim.cmd("syntax enable")


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


