return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            follow = true,
          },
          files = {
            hidden = true,
            follow = true, -- follow symlinks
            exclude = { "bindbg", "generated" },
          },
          grep = {
            hidden = true,
            follow = true,
            exclude = { "bindbg", "generated" },
          },
        },
      },
    },
    keys = {
      -- Override leader+e to always use cwd instead of root dir
      {
        "<leader>e",
        function()
          Snacks.explorer.open({ cwd = vim.uv.cwd() })
        end,
        desc = "Explorer (cwd)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer.open({ cwd = LazyVim.root() })
        end,
        desc = "Explorer (root dir)",
      },
    },
  },
  -- Disable dashboard when nvim is opened with a directory
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if vim.fn.argc() > 0 then
        opts.dashboard = opts.dashboard or {}
        opts.dashboard.autoshow = false
      end
    end,
  },
}
