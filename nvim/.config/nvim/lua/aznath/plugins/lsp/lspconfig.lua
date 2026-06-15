local function discover_servers()
  local enable_list = {}
  local servers_path = vim.fn.stdpath "config" .. "/lua/aznath/plugins/lsp/servers"

  if vim.fn.isdirectory(servers_path) == 1 then
    for _, file in ipairs(vim.fn.readdir(servers_path)) do
      local name = file:match("^(.*)%.lua$")
      if name then
        local ok, mod = pcall(require, "aznath.plugins.lsp.servers." .. name)
        if ok and type(mod) == "table" and mod.name then
          vim.lsp.config(mod.name, mod.config or {})
          table.insert(enable_list, mod.name)
        end
      end
    end
  end

  return enable_list
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- LspAttach keybinds
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", function()
          require("snacks").picker.diagnostics_buffer()
        end, opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "df", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Show signature help"
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      end,
    })

    -- Diagnostic signs
    local signs = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    }
    vim.diagnostic.config {
      signs = { text = signs },
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      float = { focusable = false, style = "minimal", border = "rounded", source = true },
    }

    vim.keymap.set("n", "<leader>lx", function()
      local current = vim.diagnostic.config().virtual_text
      vim.diagnostic.config { virtual_text = not current }
    end, { desc = "Toggle LSP virtual text" })

    -- Global capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    vim.lsp.config("*", { capabilities = capabilities })

    -- Auto-discover and enable all server configs from servers/
    vim.lsp.enable(discover_servers())
  end,
}
