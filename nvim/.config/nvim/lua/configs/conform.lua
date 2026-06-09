local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    python = { "isort", "black" },
    go = { "goimports-reviser", "gofumpt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
    -- DevOps
    yaml = { "prettier" },
    json = { "prettier" },
    terraform = { "terraform_fmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
