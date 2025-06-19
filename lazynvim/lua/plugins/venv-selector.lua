return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = function()
      require("venv-selector").setup({
        -- Your configuration options here
        name = "venv",
        auto_update = true,
      })
    end,
    event = "VeryLazy", -- or "BufReadPre" if you want it to load earlier
  },
}
