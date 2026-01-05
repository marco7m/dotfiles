---@diagnostic disable: undefined-global
---
---
return {
    -- Instalação e gerenciamento de LSPs
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true, -- Ativa configuração padrão
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "clangd" }, -- Instala servidores automaticamente
                automatic_installation = true,
            })
        end,
    },

    -- Configuração do LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            -- ⬇️ repara que NÃO tem mais: local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Adiciona suporte do LSP ao cmp
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities()
            )

            -- Função de callback para definir atalhos ao anexar um servidor LSP
            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "x" }, "<F3>", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
            end

            -- Configura os LSPs usando a API nova (Neovim 0.11+)
            local servers = { "lua_ls", "pyright", "clangd" }

            for _, server in ipairs(servers) do
                -- define/mescla config desse servidor
                vim.lsp.config(server, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    -- Se você REALMENTE quiser forçar root por .git/pyrightconfig pra todos:
                    -- root_markers = { "pyrightconfig.json", ".git" },
                })

                -- habilita o servidor (autostart baseado em filetype/root)
                vim.lsp.enable(server)
            end
        end,
    },

    -- Autocompletar
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp" }, -- Adiciona suporte a snippets
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- Snippets
                },
            })
        end,
    },
}

