# Tmux Config

A heavily customized tmux environment built for a Neovim-centric workflow.

## Quick Start

| Key | Action |
|------|--------|
| `<prefix> \|` | Split pane horizontally |
| `<prefix> -` | Split pane vertically |
| `<prefix> h/j/k/l` | Navigate panes (also works across nvim/tmux) |
| `<prefix> H/J/K/L` | Resize pane |
| `<prefix> m` | Maximize / restore pane |
| `<prefix> o` | SessionX — fuzzy session switcher |
| `<prefix> O` (hold) | Sesh — session picker (fzf-tmux) |
| `<prefix> T` | Sesh — session picker (gum) |
| `<prefix> f` | Tmux-sessionizer (new window) |
| `<prefix> n` | Create new session |
| `<prefix> w` | Pick window via fzf |
| `<prefix> v` | Enter copy mode |
| `<prefix> r` | Reload config |
| `<prefix> C-y` | Yazi file manager (popup) |
| `<prefix> C-g` | LazyGit (popup) |
| `<prefix> C-t` | Floating shell (popup) |
| `<prefix> C-m` | RMPC music client (popup) |
| `<prefix> d` | Config menu (popup) |

**Prefix** = `C-b`

---

## Detailed Guide

### Navigation — nvim ↔ tmux

Uses [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for seamless pane navigation. `Ctrl-h/j/k/l` moves focus across tmux panes **and** Neovim splits/windows without any extra key presses.

Works in normal mode in nvim and in tmux with prefix:
- `<prefix> h` — left
- `<prefix> j` — down
- `<prefix> k` — up
- `<prefix> l` — right

### Session Management

Three session pickers are configured:

1. **SessionX** (`<prefix> o`) — lightweight tmux-native session switcher. Browse, rename, kill, and filter sessions.
2. **Sesh + fzf-tmux** (`<prefix> O`) — full-featured picker using [sesh](https://github.com/joshmedeski/sesh). Supports multiple sources: `^a` (all), `^t` (tmux), `^g` (git/config), `^x` (zoxide), `^d` (kill session), `^f` (fd file system). Preview pane shows session contents.
3. **Sesh + gum** (`<prefix> T`) — simpler GUI picker with gum filter.

### Popups (Floating Windows)

All popups open relative to the current pane directory:

| Binding | Tool | Flags |
|---------|------|-------|
| `<prefix> C-y` | Yazi (file manager) | 90×90%, in cwd |
| `<prefix> C-g` | LazyGit | 90×90%, in cwd |
| `<prefix> C-t` | Floating zsh | 80×80%, in cwd |
| `<prefix> C-m` | RMPC (music) | 95×95% (global) |
| `<prefix> d` | Config menu | Choose config to edit |

The config menu (`<prefix> d`) opens a tmux menu to edit `.zshrc`, `.zprofile`, `.tmux.conf`, or nvim config in popups.

### Pane & Window Management

- **Smart splits** (`<prefix> \|` / `<prefix> -`) — open splits in the current pane's working directory.
- **Resize** (`<prefix> H/J/K/L`) — resize by 5 lines/columns, repeatable (`-r` flag).
- **Maximize** (`<prefix> m`) — toggle pane zoom.
- **Kill pane** (`<prefix> x`) — no confirmation prompt.
- **Window nav** (`<prefix> w`) — fzf-tmux picker to jump to any window.
- **New session** (`<prefix> n`) — quick named session prompt.
- **Sessionizer** (`<prefix> f`) — run `~/scripts/tmux-sessionizer.sh` in a new window.
- Config survives killing the last pane (`detach-on-destroy off`).

### Copy Mode (Vi Mode)

- `<prefix> v` — enter copy mode (vi keys)
- `v` — begin selection
- `y` — yank (copy) selection to system clipboard
- Mouse drag is unbounded (click and drag to copy)

### Status Bar (Catppuccin Mocha)

- **Left**: `` session name (turns `` red when prefix is active) + zoom indicator (` zoom`)
- **Center**: Window list — current window highlighted in blue, others in overlay, activity/bell alerts
- **Right**: Online status (`󰖩 on` / `󰖪 off`) using tmux-online-status
- Bottom position, transparent background, absolute-centre justification

### Tmux Plugin Manager (TPM)

Plugins are loaded from `~/.config/tmux/.tmux/plugins/`:

| Plugin | Purpose |
|--------|---------|
| `tmux-plugins/tpm` | Plugin manager (first) |
| `christoomey/vim-tmux-navigator` | Seamless nvim/tmux nav |
| `omerxx/tmux-sessionx` | Session picker (`<prefix> o`) |
| `catppuccin/tmux` | Status bar theme |
| `tmux-plugins/tmux-online-status` | Network status indicator |
| `tmux-plugins/tmux-battery` | Battery status (loadable) |

### Neovim Integration

| Feature | Mechanism |
|---------|-----------|
| Pane navigation | vim-tmux-navigator — `C-h/j/k/l` crosses both boundaries |
| LazyGit popup | `<prefix> C-g` — opens in cwd, closes with `q` |
| Yazi popup | `<prefix> C-y` — file manager in cwd, close with `q` |
| Floating terminal | `<prefix> C-t` — quick shell in project context |
| Config menu | `<prefix> d` — edit nvim config in a popup |
| Copy mode | Vi keybindings mirror nvim's visual mode (`v`/`y`) |

## Files

- `.tmux.conf` — the full configuration
- `README.md` — this file
