return {
  "m00qek/baleia.nvim",
  version = "*",
  config = function()
    -- guarda o objeto retornado pelo setup
    vim.opt_local.fileencoding = "utf-8"
    vim.opt_local.fileencodings = { "utf-8" }    

    local baleia = require("baleia").setup({})

    -- Comando para colorir o buffer atual
    vim.api.nvim_create_user_command("BaleiaColorize", function()
      baleia.once(vim.api.nvim_get_current_buf())
    end, { bang = true })

    -- Comando para ver logs do baleia
    vim.api.nvim_create_user_command("BaleiaLogs", function()
      baleia.logger.show()
    end, { bang = true })

    -- Auto-aplicar em arquivos .log
    vim.api.nvim_create_autocmd({"BufReadPost"}, {
      pattern = {"*.txt", "*.log"},
      callback = function()
        baleia.once(0)
      end
    })
  end,
}

