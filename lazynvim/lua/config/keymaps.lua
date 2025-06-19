-- Import fzf-lua
local fzf_lua = require("fzf-lua")

-- Define key mappings
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { noremap = true, silent = true })
-- Use fzf-lua to find files in the Neovim config directory
vim.keymap.set("n", "<leader>sx", function()
  fzf_lua.files({ cwd = vim.fn.stdpath("config") })
end, { noremap = true, silent = true, desc = "Config files" })
-- Oil
local oil = require("oil")

vim.keymap.set("n", "-", function()
  require("oil").open_float()
end, { desc = "Open Oil float" })
-- Visual mode mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Normal mode mappings
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
