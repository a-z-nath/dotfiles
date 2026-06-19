vim.g.netrw_banner = 0

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir"
vim.opt.undofile = true

-- search
vim.opt.inccommand = "split"

-- UI
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "manual"
vim.o.foldlevel = 99
vim.o.foldcolumn = "0"

-- search 
vim.o.ignorecase = true
vim.o.smartcase = true

-- window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- misc
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.isfname:append "@-@"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.clipboard:append "unnamedplus"
vim.opt.mouse = "a"

-- Soft word wrap at 80 for prose (visual only, no hard line breaks)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx", "text", "gitcommit", "help" },
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.bo.textwidth = 80
  end,
})

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})
