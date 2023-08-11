# Setup
- Go to https://brew.sh
- Follow instruction and install brew
## Run brew
```
brew bundle --file=~/dotfiles/brew/.Brewfile
```
Check out [Brew Manual](/BrewManual.md)

# Install Rosetta needed in Mac with Apple silicon
In order to run "universal" app which is usual for Intel processor, we need to manual update with Rosetta
mainly to run steam
```bash
softwareupdate --install-rosetta
```
[apple support reference](https://support.apple.com/en-us/HT211861)

# Change to fish
## Symlink fish config 
make sure symlink first before entering `fish` which generate folder and files in `.config`
```
stow fish
```
## add brew to $PATH
[stackoverflow reference](https://stackoverflow.com/questions/66724016/my-fish-is-blind-fish-does-not-recognise-any-commands-after-setting-it-as-defa)
```
fish
fish_add_path /opt/homebrew/bin
```
## Fish as default/login shell
Either edit the `/etc/shells` or go to `User & Groups > Advanced Options`. ([fish reference](https://fishshell.com/docs/current/#default-shell))
```
echo $(which fish) | sudo tee -a /etc/shells # if not already exists
chsh -s $(which fish)
```

# go to dotfile directory and symlink using stow
```
stow brew
stow kitty
stow tmux
stow karabiner
```

# Node
## FNM
```
fnm list
fnm install 18 # node v18.17.0
fnm use 18
fnm default 18
```

# Neovim

## karabiner & keybinding
mainly to switch ctrl to caplock

# raycast
## Todo
- Keyboard Shortcut > Spotlight > Off Show Spotlight search
- Change Raycast hotkey to `CMD + space`
## Usage
- window manager

# Others
## stats
preference setup: [(battery_percent, housrs), network_in_out, disk_bar, gpu_bar, ram_pi_chart, clock_date]



# Setting up for work
## Google Chrome
- sign in to google account
- install Yomichan all 4 dictionaries (kanjidic, kireicake, jmnedict, jmdict)
## Slack

# Setting up for Myself
## Notion

# Install IDE: neovim
## install vim-plug & plugins
```bash
./init_vim.sh
```

## install typescript & tsserver
- run `yarn global add typescript typescript-language-server`

## Run Macos preference setup
```
./init_macos.sh

```


# Communication
## Messenger
## Telegram
[telegram or telegram-desktop](https://www.reddit.com/r/Telegram/comments/9apvh4/qmac_os_x_telegram_vs_telegram_desktop_which_one/)

### This includes
- [x] Finder app config preference
- [x] Dock config preference
- [ ] Hot corners?
- [ ] Safari & Webkit:q

# TODO
- [ ] Use stow to symlink all this to .config
 - [ ] brew install stow, stow symlink brew global :think:

# Reference

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
