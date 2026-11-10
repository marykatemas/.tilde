return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ps1 = { "pwsh" },
    },
    formatters = {
      pwsh = {
        command = "pwsh",
        args = {
          "-NoProfile",
          "-Command",
          "Invoke-Formatter -ScriptDefinition ([Console]::In.ReadToEnd())",
        },
        stdin = true,
      },
    },
  },
}
