set fish_greeting ""

set -gx TERM screen-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set fish_key_bindings fish_user_key_bindings
set fish_bind_mode insert

# This append into fish path everytime config is reload
# set -gx PATH bin $PATH

set -gx EDITOR nvim

# navigation
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"

# git
alias g git
alias gst "git status"
alias glo "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gd "git diff"
alias gdc "git diff --cached"
alias gs "git show"
alias gc "git commit"

# file
alias vim "nvim"
alias v "nvim"

set -gx SITE_DIR $HOME/Sites
set -gx DOTFILE_DIR $SITE_DIR/dotfiles
set -gx NEOVIM_DIR $DOTFILE_DIR/neovim/.config/nvim
set -gx FISH_DIR $DOTFILE_DIR/fish/.config/fish
set -gx TMUX_DIR $DOTFILE_DIR/tmux/.config/tmux
set -gx VIMRC $NEOVIM_DIR/init.lua

alias vc "v -O $NEOVIM_DIR/init.lua $NEOVIM_DIR/lua/keymaps.lua $NEOVIM_DIR/lua/plugins-setup.lua"
alias fc "v -O $FISH_DIR/config.fish $FISH_DIR/functions/dotfile.fish"
alias tc "v $TMUX_DIR/tmux.conf"

alias bc "v $DOTFILE_DIR/brew/.Brewfile"
alias bi "brew bundle --global"
alias brew_cleanup "brew bundle cleanup --global"

if status is-interactive
  # cd $SITE_DIR # conflicts with 'tmux new -c' session
  # Commands to run in interactive sessions can go here
end

