BREW_BIN      := /opt/homebrew/bin
XDG_DATA_HOME := $(HOME)/.local/share

BREW          := $(BREW_BIN)/brew
NVIM          := $(BREW_BIN)/nvim
STOW          := $(BREW_BIN)/stow
GIT           := $(BREW_BIN)/git

STOW_PKGS     := nvim 
#STOW_PKGS     := emacs fish git kitty nvim starship tmux

all:

fish:
	stow fish
tmux:
	stow tmux
neovim:
	stow -vSt ~ neovim
karabiner:
	stow -vSt ~ karabiner
hammerspoon:
	stow -vSt ~ hammerspoon 
brew:
	stow -vSt ~ brew
kitty:
	stow -vSt ~ kitty
