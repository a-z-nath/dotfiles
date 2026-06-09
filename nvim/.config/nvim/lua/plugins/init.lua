return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",

        -- Web Dev (JS/TS/HTML/CSS)
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",

        -- Python
        "pyright",
        "black",
        "isort",
        "debugpy",
        "mypy",
        "ruff",

        -- C/C++
        "clangd",
        "clang-format",
        "codelldb",

        -- Go
        "gopls",
        "gofumpt",
        "goimports-reviser",
        "delve",

        -- Java
        "jdtls",
        "java-debug-adapter",
        "google-java-format",

        -- DevOps (Docker, Terraform, Yaml)
        "dockerfile-language-server",
        "terraform-ls",
        "yaml-language-server",
        "ansible-language-server",
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Required by newer nvim-dap-ui
    },
    config = function()
      require "configs.dap"
    end,
  },
  -- Language Specific Extra Features
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}
