-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
function Transparent(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)
  vim.opt.background = "dark"
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
end
Transparent("oxocarbon")
