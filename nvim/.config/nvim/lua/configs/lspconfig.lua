local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

-- 1. List of generic servers
local servers = {
  "html", "cssls", "clangd", "gopls", "pyright", 
  "dockerls", "terraformls", "yamlls", "ansiblels"
}

-- 2. Setup generic servers
for _, name in ipairs(servers) do
  -- Register the config
  vim.lsp.config(name, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  -- Enable the server (creates the FileType autocmds)
  vim.lsp.enable(name)
end

-- 3. TypeScript Setup (ts_ls)
vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
})
vim.lsp.enable("ts_ls")

-- 4. Java Setup (jdtls)
vim.lsp.config("jdtls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "jdtls" },
})
vim.lsp.enable("jdtls")
