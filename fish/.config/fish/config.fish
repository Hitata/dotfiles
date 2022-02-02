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
alias glo "git log"
alias gdc "git diff --cached"
alias gd "git diff"
alias gs "git show"

set -gx PATH bin $PATH

set -U EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end
