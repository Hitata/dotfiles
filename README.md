# Setup
- Run install brew

# Install Rosetta needed in Mac with Apple silicon
In order to run "universal" app which is usual for Intel processor, we need to manual update with Rosetta
```bash
softwareupdate --install-rosetta
```
[apple support reference](https://support.apple.com/en-us/HT211861)

# Install IDE: neovim
## install vim-plug
- run `nvim +PlugInstall +qall`

## install typescript & tsserver
- run `yarn global add typescript typescript-language-server`

## Setup fish prompt
- Add fish to know shells
```bash
which fish
sudo su - c 'echo /opt/homebrew/bin/fish >> /etc/shells'
```
- Restart your terminal (kitty)
- set fish as default shell
```
chsh -s /opt/homebrew/bin/fish
```
- Add brew binaries in fish path
```
fish_add_path -U /opt/homebrew/bin
```
[fish_add_path docs](https://fishshell.com/docs/current/cmds/fish_add_path.html)

# TODO
- [ ] Use stow to symlink all this to .config
- [ ] add karabiner-element json config
