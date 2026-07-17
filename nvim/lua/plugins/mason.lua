return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      -- Java
      "jdtls",
      -- Python
      "pyright",
      "black",
      -- Web
      "html-lsp",
      "css-lsp",
      "typescript-language-server",
      -- Django
      "djlsp",
    },
  },
}
