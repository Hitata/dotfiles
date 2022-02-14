set fish_greeting ""

set -gx TERM screen-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# This append into fish path everytime config is reload
# set -gx PATH bin $PATH

set -U EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

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

# file
alias vim "nvim"
alias v "nvim"

set -gx DOTFILE_DIR ~/Sites/dotfiles

alias fc "v $DOTFILE_DIR/fish/.config/fish/config.fish"
alias vc "v $DOTFILE_DIR/neovim/.config/nvim/init.vim"
alias tc "v $DOTFILE_DIR/tmux/.config/tmux/tmux.conf"
alias bc "v $DOTFILE_DIR/Brewfile"
alias bmake "make -C $DOTFILE_DIR brew"

