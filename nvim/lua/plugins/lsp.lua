return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lua
        lua_ls = {},
        -- Python
        pyright = {},
        -- HTML
        html = {},
        -- CSS
        cssls = {},
        -- JavaScript/TypeScript
        ts_ls = {},
        -- Django templates (uses django-html filetype)
        djlsp = {},
        -- Java
        jdtls = {
          cmd_env = {
            JAVA_HOME = "/home/ehernesten/.pixi/envs/jdk21/lib/jvm",
          },
          settings = {
            java = {
              format = {
                tabSize = 3,
                insertSpaces = true,
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = "/home/ehernesten/.pixi/envs/openjdk/lib/jvm",
                    default = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
