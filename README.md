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

## Run Macos preference setup
```fish
./init_macos.sh

```
### This includes
- [x] Finder app config preference
- [x] Dock config preference
- [ ] Hot corners?
- [ ] Safari & Webkit:q

# TODO
- [ ] Use stow to symlink all this to .config
- [ ] add karabiner-element json config

# Reference
## Fish cookbook
https://github.com/jorgebucaran/cookbook.fish

# Git commit convention
## types
- [x] fixs: patch
- [x] feat: minor
- [x] docs: documents
- [x] refa: refactor
- [x] perf: performance improvement
- [x] test: write tests
- [x] cicd: CI/CD stuff
- [x] buil:
- [x] chor:
- [x] styl:

## scope
- [x] brew
- [x] nvim
- [x] fish
- [x] tmux
- [x] kitty
- [x] hammerspoon

## description format
- must be in imperative mood, which is a demand
- Can fit into this sentense: If applied this commmit will `your subject line here`
- atomic commits approach: commit each fix/task as separate change
```
Ex:
1. feat(brew): install brave for browsing web without ads
2. fix(hammerspoon): update WindowMove spoon to hyper+m
3. docs(nvim): update git blame keybind to ,gco
```
