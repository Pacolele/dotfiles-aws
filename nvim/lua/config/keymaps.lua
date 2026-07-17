-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Jump backward/forward in history
vim.keymap.set("n", "[[", "<C-o>", { desc = "Jump backward" })
vim.keymap.set("n", "]]", "<C-i>", { desc = "Jump forward" })

-- Quick outline (like VSCode Ctrl+Shift+O)
vim.keymap.set("n", "<leader>o", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Quick Outline (symbols)" })
