# Neovim keymap

Leader: `,`. Config: `home/dot_config/nvim/`.

## Core

| Chord | Action |
|---|---|
| `jk` | Save file (insert-mode escape + write) |
| `<S-k>` | Show help / go to definition (LSP hover) |
| `,cv` | Open `$MYVIMRC` |
| `,sv` | Source `$MYVIMRC` |

## nvim-tree

| Chord | Action |
|---|---|
| `,n` | Focus tree |
| `g?` | Help |
| `<C-k>` | Show node info |
| `a` | Add node |
| `r` | Rename node |
| `d` | Delete node |
| `R` | Refresh |
| `m` | Bookmark |

## Comments

| Chord | Action |
|---|---|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc2j` | Toggle comment on 3 lines below (current + 2) |

## Git

| Chord | Action |
|---|---|
| `:G status` | Git status |
| `,ga` | Stage current hunk |
| `,gu` | Undo current hunk |
| `,gn` | Next hunk |
| `,gp` | Previous hunk |
| `,gb` | Open current line in GitHub browser |
| `v{motion},gb` | Open selection range in GitHub browser |

## Navigation / jumps

| Chord | Action |
|---|---|
| `<C-o>` | Jump back |
| `<C-i>` | Jump forward |
| `:ju` | Show jump list |
| `<C-^>` | Previous file |

See `:h jump-motions` for the full list of motion-class jumps.

## File navigation

| Chord | Action |
|---|---|
| `gf` | Go to file under cursor |
| `<C-w>f` | Open file under cursor in split |
| `<C-f>` | fzf over all files |
| `<C-p>` | fzf over git-tracked files |
| `<C-x>` (inside fzf) | Open in horizontal split |
| `<C-v>` (inside fzf) | Open in vertical split |
| `<C-t>` (inside fzf) | Open in new tab |
