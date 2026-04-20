# dotfiles

Managed by [chezmoi](https://www.chezmoi.io). One source of truth for fish,
tmux, nvim, hammerspoon, karabiner, ghostty, claude, and package manifests
(brew/apt/snap/npm).

## Bootstrap a fresh machine

### macOS

```bash
git clone git@github.com:Hitata/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

`install.sh` is idempotent. It:

1. Installs Homebrew if missing
2. Installs chezmoi
3. Symlinks `~/.local/share/chezmoi` → `~/dotfiles/home`
4. Runs `chezmoi apply`, which fires the `run_once` / `run_onchange` hooks
   (brew bundle, nvim plugins, npm globals).

After first apply, set fish as login shell:

```bash
echo (which fish) | sudo tee -a /etc/shells
chsh -s (which fish)
```

Apple Silicon machines that need Intel apps (e.g. Steam):

```bash
softwareupdate --install-rosetta
```

### Ubuntu

See [UBUNTU_SETUP.md](UBUNTU_SETUP.md). One-liner bootstrap via `chezmoi init --apply Hitata`.

## Daily workflow

```bash
chezmoi status    # see drift between repo and $HOME
chezmoi apply     # pull repo state into $HOME
chezmoi re-add    # pull local edits back into the repo (when you edit ~/.config/* directly)
```

Edit configs in `~/dotfiles/home/dot_config/...` and commit. `chezmoi apply`
any time after pulling changes on another machine.

## Package manifests

| Manifest | Location | Applied by |
|---|---|---|
| Homebrew | `home/dot_config/brew/Brewfile` | `run_onchange_after_install-brew.sh.tmpl` |
| APT | `home/dot_config/apt/packages.txt` | `run_onchange_after_install-apt.sh.tmpl` |
| Snap | `home/dot_config/snap/packages.txt` | `run_onchange_after_install-snap.sh.tmpl` |
| npm globals | `home/dot_config/npm/globals.txt` | `run_onchange_after_install-npm-globals.sh.tmpl` |

Add a line, commit, `chezmoi apply` — the hook re-runs when the manifest changes.

See [BrewManual.md](BrewManual.md) for brew bundle commands.

## Keymaps

- [TMUX_KEYMAP.md](TMUX_KEYMAP.md) — prefix is `C-a`
- [VIM_KEYMAP.md](VIM_KEYMAP.md) — leader is `,`
- [YOUTUBE_KEYMAP.md](YOUTUBE_KEYMAP.md)

## Hammerspoon (macOS)

Hyper key is **F19** (remapped from CapsLock via karabiner).

| Chord | App |
|---|---|
| F19 + 1 | Ghostty |
| F19 + 2 | Obsidian |
| F19 + 3 | Chrome |
| F19 + 4 | Slack |
| F19 + q | Cursor |
| F19 + Shift + R | Reload Hammerspoon |
| F19 + Shift + T | Toggle Hammerspoon console |
| Cmd + Alt + arrow | MiroWindowsManager tile |

## Claude Code

- Setup notes: [CLAUDE_SETUP.md](CLAUDE_SETUP.md)
- Telegram notifications: [CLAUDE_TELEGRAM.md](CLAUDE_TELEGRAM.md)

## Node (fnm)

```bash
fnm install 22
fnm default 22
```

## Git commit convention

`<type>(<scope>): <imperative subject>` — atomic, in imperative mood ("If
applied this commit will…").

**Types:** `feat` `fix` `docs` `refa` `perf` `test` `cicd` `buil` `chor` `styl`

**Common scopes:** `brew` `nvim` `fish` `tmux` `hammerspoon` `ghostty` `claude` `chezmoi`

Examples:

```
feat(hammerspoon): bind Hyper+1 to Ghostty instead of Terminal
fix(tmux): switch default-shell to homebrew fish path
docs(nvim): document :G status binding
```
