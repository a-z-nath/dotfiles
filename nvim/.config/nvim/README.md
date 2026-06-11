# Neovim Configuration

A custom Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim). Uses the **chadracula-evondev** theme (via [NvChad/base46](https://github.com/NvChad/base46)).

## Plugins

### Bootstrap / Utility

| Plugin | Purpose |
|--------|---------|
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Utility library required by many plugins |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless tmux & split-window navigation |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | LuaLS type annotations for config development |

### Colorschemes

| Plugin | Notes |
|--------|-------|
| [rose-pine/neovim](https://github.com/rose-pine/neovim) | |
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | |
| [solarized-osaka.nvim](https://github.com/craftzdog/solarized-osaka.nvim) | |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | |
| [monokai-pro.nvim](https://github.com/loctvl842/monokai-pro.nvim) | |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | |
| [base46](https://github.com/NvChad/base46) | NvChad theme engine (active: chadracula-evondev) |

### Editor Enhancement

| Plugin | Purpose |
|--------|---------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets and quotes |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle code comments (`gc`, `gb`) |
| [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Treesitter-aware comment context |
| [nvim-emmet](https://github.com/olrtg/nvim-emmet) | Emmet abbreviation support |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Highlight color codes inline |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Library of mini modules |
| [mini.files](https://github.com/echasnovski/mini.files) | File explorer |
| [mini.surround](https://github.com/echasnovski/mini.surround) | Add/delete/replace surroundings |
| [mini.trailspace](https://github.com/echasnovski/mini.trailspace) | Trim trailing whitespace |
| [mini.splitjoin](https://github.com/echasnovski/mini.splitjoin) | Toggle single/multi-line arguments |
| [mini.notify](https://github.com/echasnovski/mini.notify) | Notification system |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer as editable buffer |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting engine |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting engine |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Code folding (treesitter + indent) |
| [promise-async](https://github.com/kevinhwang91/promise-async) | Async library (dependency) |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing and highlighting |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close HTML/JSX tags |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown rendering |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/FIXME/HACK comments |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics, quickfix, and loclist viewer |
| [undotree](https://github.com/mbbill/undotree) | Visual undo history tree |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Toggle maximize/restore split |
| [showkeys](https://github.com/nvzone/showkeys) | On-screen key display |

### Fuzzy Finding / Navigation

| Plugin | Purpose |
|--------|---------|
| [fff.nvim](https://github.com/dmtrKovalenko/fff.nvim) | Fast file finder + live grep |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Picker, lazygit, rename, bufdelete, dashboard |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Classic fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorter for Telescope |
| [telescope-themes](https://github.com/andrew-george/telescope-themes) | Theme switcher via Telescope |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file marking and jumping |

### Git

| Plugin | Purpose |
|--------|---------|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter |
| [git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) | Git worktree management |

### Completion / Snippets

| Plugin | Purpose |
|--------|---------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Premade snippets collection |

### LSP / Mason

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations) | LSP-based file operations |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/DAP/linter/formatter installer |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridge between Mason and lspconfig |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools |

#### LSP Servers
`lua_ls`, `ts_ls`, `cssls`, `tailwindcss`, `gopls`, `rust_analyzer`, `astro`, `emmet_language_server`, `emmet_ls`, `marksman`, `clangd`, `denols`

#### Auto-installed Tools
`biome`, `prettier`, `stylua`, `isort`, `pylint`

### Statusline

| Plugin | Purpose |
|--------|---------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Customizable statusline |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons |

## Keybindings

Leader key is `<Space>`.

### Core

| Key | Mode | Action |
|-----|------|--------|
| `<leader><leader>` | n | Source current file |
| `J` / `K` | v | Move lines down / up |
| `<C-d>` / `<C-u>` | n | Page down/up, center cursor |
| `n` / `N` | n | Next/prev search result, centered |
| `<leader>d` | n, v | Delete to black hole register |
| `<C-c>` | n | Clear search highlight |
| `<leader>f` | n | Format buffer via LSP |
| `<leader>s` | n | Replace word under cursor globally |
| `<leader>X` | n | Make file executable |

### Splits and Tabs

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>tf` | Open buffer in new tab |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `gt` | n | Go to type definition |
| `gR` | n | Show references |
| `K` | n | Hover documentation |
| `<C-h>` | i | Signature help |
| `<leader>vca` | n, v | Code actions |
| `<leader>rn` | n | Smart rename |
| `<leader>D` | n | Buffer diagnostics |
| `<leader>lx` | n | Toggle virtual text |
| `df` | n | Float diagnostics |
| `<leader>lr` | n | Restart LSP |

### File Finding

| Key | Action |
|-----|--------|
| `<leader>pf` | FFF find files |
| `<leader>ps` | FFF live grep |
| `<leader>pgf` | FFF in git root |
| `<leader>pcf` | FFF in neovim config |
| `<leader>pr` | Telescope recent files |
| `<leader>pWs` | Grep word under cursor |
| `<leader>pk` | Snacks keymaps picker |
| `<leader>vh` | Snacks help pages |
| `<leader>pws` | Snacks grep word |
| `<leader>pt` | Snacks todo comments |
| `<leader>th` | Snacks colorscheme picker |

### Harpoon

| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<C-y>` / `<C-i>` / `<C-n>` / `<C-s>` | Jump to marks 1–4 |
| `<C-S-P>` / `<C-S-N>` | Previous / next harpoon buffer |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Fugitive fullscreen |
| `<leader>lg` | Snacks lazygit |
| `<leader>gl` | Snacks lazygit log |
| `]h` / `[h` | Next / previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gbl` | Blame line |
| `<leader>gB` | Toggle line blame |
| `<leader>gd` / `<leader>gD` | Diffthis |
| `ih` | Text object for hunk |
| `<leader>wl` | List worktrees |
| `<leader>wc` | Create worktree |

### File Explorer

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle mini.files |
| `<leader>ef` | Reveal current file |
| `-` | Open oil (parent directory) |
| `<leader>-` | Oil in float |

### Code / Comments

| Key | Mode | Action |
|-----|------|--------|
| `gc` | n, v | Toggle comment (linewise) |
| `gb` | n, v | Toggle comment (blockwise) |
| `<leader>mp` | n, v | Format with conform |
| `<leader>l` | n | Trigger lint |
| `<leader>xe` | n, v | Emmet wrap with abbreviation |

### Surround / Text

| Key | Action |
|-----|--------|
| `sa` | Add surrounding |
| `ds` | Delete surrounding |
| `ca` | Replace surrounding |
| `sf` / `sF` | Find surrounding right / left |
| `sh` | Highlight surrounding |
| `sj` | Join arguments |
| `sk` | Split arguments |
| `<leader>cw` | Trim trailing whitespace |

### Folding

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |

### TODO Comments

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next / previous todo comment |
| `<leader>pt` | List all todo comments |
| `<leader>pT` | List main todos |

### Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | Todo comments |

### Utility

| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undotree |
| `<leader>mx` | Maximize split |
| `<leader>ks` | Toggle showkeys |
| `<leader>dB` | Delete buffer (snacks) |
| `<leader>rN` | Rename file (snacks) |
| `<leader>re` | Restart Neovim |
| `<leader>fp` | Copy filepath |

### Markdown (buffer-local)

| Key | Action |
|-----|--------|
| `tn` / `tb` / `tc` / `tt` / `tl` | Toggle list types (visual) |
| `<leader>h1`–`<leader>h6` | Toggle headings |
| `<leader>tc` | Mark all tasks done |
| `<leader>tu` | Mark all tasks undone |

### Window Navigation (vim-tmux-navigator)

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate splits / tmux panes |

### Completion (blink.cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-space>` | i | Open completion |
| `<C-y>` | i | Confirm selection |
| `<C-n>` / `<C-p>` | i | Next / previous item |
| `<C-e>` | i | Cancel |
| `<C-b>` / `<C-f>` | i | Scroll docs |
