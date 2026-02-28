return {
  {
    "EdenEast/nightfox.nvim",
    version = "v1.0.0",
    lazy = false,
    priority = 900,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "wave",
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
