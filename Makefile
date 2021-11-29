DOTFILES=${HOME}/.dotfiles
CONFIG=${HOME}/.config

all:
	brew
install:
	kitty
kitty:
	stow --restow --ignore ".DS_store" --target="${CONFIG}" --dir="${DOTFILES}" kitty
brew:
	brew bundle --file="${DOTFILES}/Brewfile"

