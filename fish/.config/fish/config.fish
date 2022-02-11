set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias gst "git status"
alias glo="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gdc "git diff --cached"
alias gd "git diff"
alias gs "git show"

alias vim="nvim"
alias v="nvim"
alias vconf="~/Sites/dotfiles/nvim/.config/nvim/init.vim"
alias dotconf="vim ~/.dotfiles"
alias bconf="vim ~/Sites/dotfiles/Brewfile"
alias bmake="make -C ~/Sites/dotfiles brew"

set -gx PATH bin $PATH

set -U EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end
