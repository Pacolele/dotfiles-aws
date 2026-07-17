-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Java: 3-space indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.opt_local.shiftwidth = 3
    vim.opt_local.tabstop = 3
    vim.opt_local.softtabstop = 3
    vim.opt_local.expandtab = true
  end,
})
