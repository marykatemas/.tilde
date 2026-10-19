return {
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "rebelot/kanagawa.nvim" },
  { "datsfilipe/vesper.nvim" },
  {
    "nyoom-engineering/oxocarbon.nvim",
    build = false,
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      -- Available values:   `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
      vim.g.sonokai_style = "default"
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
