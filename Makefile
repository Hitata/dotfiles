BREW_BIN      := /opt/homebrew/bin
XDG_DATA_HOME := $(HOME)/.local/share

BREW          := $(BREW_BIN)/brew
NVIM          := $(BREW_BIN)/nvim
STOW          := $(BREW_BIN)/stow
GIT           := $(BREW_BIN)/git

STOW_PKGS     := nvim
#STOW_PKGS     := emacs fish git nvim starship tmux

all: brew
	@echo "install all"
# fish, tmux, nvim, karabiner, hammerspoon, claude, npm globals → chezmoi apply
# Brewfile is invoked by path — no symlink required.
brew:
	$(BREW) bundle --file=$(CURDIR)/brew/.Brewfile
