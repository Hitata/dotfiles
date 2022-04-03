BREW_BIN      := /opt/homebrew/bin
XDG_DATA_HOME := $(HOME)/.local/share

BREW          := $(BREW_BIN)/brew
NVIM          := $(BREW_BIN)/nvim
STOW          := $(BREW_BIN)/stow
GIT           := $(BREW_BIN)/git
VPLUG      := $(XDG_DATA_HOME)/nvim/site/autoload/plug.vim

STOW_PKGS     := nvim 
#STOW_PKGS     := emacs fish git kitty nvim starship tmux

all:
	brew
nvim:
	stow -vSt ~ nvim
karabiner:
	stow -vSt ~ karabiner
hammerspoon:
	stow -vSt ~ hammerspoon 
hyper:
	stow -vSt ~ hyper
brew:
	stow -vSt ~ brew

plug: | $(NVIM)
	curl -fLo $(VPLUG) --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	chmod +x $(VPLUG)
	sh -c $(VPLUG)
	$(NVIM) +PlugInstall +qall

