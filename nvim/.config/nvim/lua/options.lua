require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- ============================================================================
-- Indentation Options (Added)
-- ============================================================================
vim.o.tabstop = 4       -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4    -- Size of an indent (used by >>, <<, and autoindent)
vim.o.softtabstop = 4   -- Number of spaces that a <Tab> counts for while editing
vim.o.expandtab = true  -- Convert tabs to spaces (recommended for web/devops)
vim.o.smartindent = true -- Insert indents automatically

-- ============================================================================
-- Core editor options
-- ============================================================================

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Mouse support
vim.o.mouse = 'a'

-- Do not show mode (handled by statusline)
vim.o.showmode = true

-- Enable break indent
vim.o.breakindent = true

-- Persistent undo
vim.o.undofile = true

-- Search behavior
vim.o.ignorecase = true
vim.o.smartcase = true

-- Always show signcolumn
vim.o.signcolumn = 'yes'

-- Faster UI responsiveness
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace visualization
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- Incremental substitute preview
vim.o.inccommand = 'split'

-- Highlight current line
vim.o.cursorline = true

-- Context around cursor
vim.o.scrolloff = 10

-- Confirm instead of failing on unsaved changes
vim.o.confirm = true

vim.o.textwidth = 80
vim.o.wrap = true
