return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
      dashboard = {
        preset = {
          header = [[
 ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░     ░░   ▒ ░░      ░   
         ░      ░   ░         ░   
               ░                  ]],
          keys = {
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 0, padding = 1 },
          {
            icon = " ",
            key = "r",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
            title = "[R]ecent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          {
            icon = " ",
            key = "p",
            action = ":lua Snacks.dashboard.pick('projects')",
            title = "[P]rojects",
            section = "projects",
            indent = 2,
            padding = 1,
          },
          {
            title = "[K]eymaps",
            key = "k",
            action = ":lua Snacks.dashboard.pick('keymaps')",
            align = "center",
            padding = 1,
          },
          { section = "startup" },
        },
      },
    },
    keys = {
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide Picker",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>t",
        function()
          local file = vim.uv.fs_stat("TODO.md") and "TODO.md"
            or "~/Library/Mobile Documents/com~apple~CloudDocs/TODO.md"
          Snacks.scratch({ icon = " ", name = "Todo", ft = "markdown", file = file })
        end,
        desc = "Todo List",
      },
      {
        "<leader>T",
        function()
          Snacks.scratch({
            icon = " ",
            name = "Todo",
            ft = "markdown",
            file = "~/Library/Mobile Documents/com~apple~CloudDocs/TODO.md",
          })
        end,
        desc = "Todo List",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
  },
}
