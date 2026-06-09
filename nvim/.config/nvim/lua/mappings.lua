require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Basic Mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-F>", "<C-F>zz") -- Scroll down and center
map("n", "<C-U>", "<C-U>zz") -- Scroll up and center
map("n", "<leader>s", ":source <cr>", { desc = "Source Neovim Repo" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
map("n", ";", ";")

-- ==========================================
-- Essential Plugin Mappings
-- ==========================================

-- Formatting (Conform)
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "General Format file" })

-- Debugging (DAP)
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Debug Toggle Breakpoint" })
map("n", "<leader>ds", "<cmd> DapContinue <CR>", { desc = "Debug Start/Continue" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Debug Step Into" })
map("n", "<leader>do", "<cmd> DapStepOver <CR>", { desc = "Debug Step Over" })
map("n", "<leader>dO", "<cmd> DapStepOut <CR>", { desc = "Debug Step Out" })
map("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Debug Terminate Session" })
-- Toggle Debug UI
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug Toggle UI" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Switch Window Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window Up" })

-- Code Actions
map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions"})
map('n', ']d', vim.diagnostic.goto_next, {desc = "Next Diagnostic"})
map('n', '[d', vim.diagnostic.goto_prev, {desc = "Prev Diagnostic"})


-- Map c, x, and s to use the black hole register ("_)
-- This prevents them from overwriting your clipboard

local modes = { 'n', 'v' } -- Normal and Visual modes

-- 'x' (delete character)
vim.keymap.set(modes, 'x', '"_x')

-- 'c' (change)
vim.keymap.set(modes, 'c', '"_c')

-- 's' (substitute)
vim.keymap.set(modes, 's', '"_s')

-- Optional: 'cc' (change line) isn't strictly caught by 'c' mapping in some contexts
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('n', 'S', '"_S')
