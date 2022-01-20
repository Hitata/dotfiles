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


# TODO
- [ ] Use stow to symlink all this to .config
- [ ] add karabiner-element json config
