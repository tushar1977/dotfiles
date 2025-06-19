return {
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy", -- Adjust to load the plugin as needed
    opts = {
      enable = true, -- Enable the plugin globally
      filetypes = {
        "html",
        "xml",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "svelte",
        "jsx",
        "tsx",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
      },
      skip_tags = {
        "area",
        "base",
        "br",
        "col",
        "command",
        "embed",
        "hr",
        "img",
        "input",
        "keygen",
        "link",
        "meta",
        "param",
        "source",
        "track",
        "wbr",
      },
    },
  },
}
