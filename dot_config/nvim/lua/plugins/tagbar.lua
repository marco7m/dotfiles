return {
    "preservim/tagbar",
    cmd = "TagbarToggle",
    config = function()
        -- Configuração do tagbar
        vim.g.tagbar_width = 30
        vim.g.tagbar_autofocus = 1
        vim.g.tagbar_sort = 0 -- Mantém a ordem original dos símbolos

        local function has_rust_ctags_support(bin)
            if vim.fn.executable(bin) == 0 then
                return false
            end

            local out = vim.fn.system({ bin, "--list-languages" })
            return vim.v.shell_error == 0 and out:find("Rust", 1, true) ~= nil
        end

        local rust_ctags_bin
        for _, bin in ipairs({ "ctags-universal", "uctags", "universal-ctags", "ctags" }) do
            if has_rust_ctags_support(bin) then
                rust_ctags_bin = bin
                break
            end
        end

        if rust_ctags_bin then
            -- Force universal ctags, otherwise Tagbar may pick Exuberant `ctags`.
            vim.g.tagbar_ctags_bin = rust_ctags_bin
        else
            vim.schedule(function()
                vim.notify(
                    "Tagbar Rust needs Universal Ctags (no Rust-capable ctags found).",
                    vim.log.levels.WARN
                )
            end)
        end

        -- Atalho para abrir/fechar o tagbar
        -- vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true, desc = "Toggle Tagbar" })
    end
}
