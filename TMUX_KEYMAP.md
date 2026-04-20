# tmux keymap

Prefix: `C-a` (rebound from `C-b`). Config: `home/dot_config/tmux/tmux.conf`.

## Windows

| Chord | Action |
|---|---|
| `<C-a> c` | New window (inherits current path) |
| `<C-a> ,` | Rename current window |
| `<C-a> w` | Window list |
| `<C-a> 1`–`9` | Jump to window N |
| `<C-a> a` | Toggle to last window |
| `<C-a> b` | Break pane into new window |

## Panes

| Chord | Action |
|---|---|
| `<C-a> \` | Split horizontal (inherits current path) |
| `<C-a> -` | Split vertical (inherits current path) |
| `<C-a> h/j/k/l` | Move focus (vim-style) |
| `<C-a> H/J/K/L` | Resize pane by 5 |
| `<C-a> C-h/j/k/l` | Swap pane in direction |
| `<C-a> z` | Toggle pane zoom (fullscreen) |

## Session

| Chord | Action |
|---|---|
| `<C-a> d` | Detach |
| `<C-a> r` | Reload `tmux.conf` |
| `<C-a> o` | Open pane's cwd in Finder |

## Copy mode (vi)

| Chord | Action |
|---|---|
| `<C-a> [` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection → pbcopy (also works over SSH via OSC 52) |
| `q` / `Esc` | Exit copy mode |
