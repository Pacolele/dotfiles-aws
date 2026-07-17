-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.vscode then
  -- Enable showmode so vscode-neovim reports mode as "-- INSERT --" etc.
  -- Required for neovim-statusline extension to detect mode changes.
  vim.opt.showmode = true
end
