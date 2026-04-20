# Put Homebrew on PATH for every fish shell.
# Works on Apple Silicon (/opt/homebrew) and Linuxbrew (/home/linuxbrew).
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end
