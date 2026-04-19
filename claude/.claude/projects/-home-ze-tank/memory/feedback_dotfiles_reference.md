---
name: Refer to dotfiles for tool/config questions
description: For questions about tmux, vim/neovim, fish, kitty, hammerspoon, karabiner keybindings/config, check ~/dotfiles before giving generic answers
type: feedback
originSessionId: df4013fd-6259-4fce-90b7-7a59c1239292
---
When the user asks about keybindings, shortcuts, or configuration for tools they use (tmux, vim/neovim, fish, kitty, hammerspoon, karabiner, etc.), read their dotfiles instead of giving generic/default answers.

**Why:** User maintains a personalized dotfiles repo with custom bindings that differ from defaults (e.g., tmux prefix is `C-a` not `C-b`; splits bound to `¥` and `-`). Generic answers mislead them.

**How to apply:**
- Dotfiles live at `~/dotfiles/` (tmux, neovim, fish, kitty, hammerspoon, karabiner, claude, brew, macos subdirs)
- Curated keymap references: `~/dotfiles/TMUX_KEYMAP.md`, `~/dotfiles/VIM_KEYMAP.md`, `~/dotfiles/YOUTUBE_KEYMAP.md` — read these first for quick keybinding answers
- Full configs (for anything not in the keymap docs): `~/dotfiles/tmux/.config/tmux/tmux.conf`, `~/dotfiles/neovim/`, etc.
