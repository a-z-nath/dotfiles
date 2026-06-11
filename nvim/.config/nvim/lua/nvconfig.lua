local M = {}

M.base46 = {
  theme = "chadracula-evondev",
  transparency = false,
  hl_add = {},
  hl_override = {},
  integrations = {},
  excluded = { "blink", "cmp" },
  changed_themes = {},
  theme_toggle = { "chadracula-evondev", "chadracula-evondev" },
}

M.ui = {
  cmp = { style = "default" },
  telescope = { style = "borderless" },
  statusline = { enabled = false },
  tabufline = { enabled = false },
}

M.cheatsheet = { theme = "grid" }
M.mason = { pkgs = {}, skip = {} }
M.lsp = { signature = true }
M.colorify = { enabled = false }

return M
