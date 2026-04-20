#!/bin/bash
# Bootstrap this dotfiles repo via chezmoi.
# Idempotent — safe to re-run on an already-configured machine.

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi"
CHEZMOI_CONFIG="$HOME/.config/chezmoi/chezmoi.toml"

echo "==> Dotfiles: $DOTFILES"

# --- Homebrew ---
# Source shellenv from a known install path before deciding whether to install.
# Otherwise a brew that exists on disk but isn't on this shell's PATH gets reinstalled.
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "==> Homebrew: already installed"
fi

# --- chezmoi ---
if ! command -v chezmoi &>/dev/null; then
    echo "==> Installing chezmoi"
    brew install chezmoi
else
    echo "==> chezmoi: already installed"
fi

# --- Link chezmoi source → this repo's home/ directory ---
if [ ! -L "$CHEZMOI_SOURCE" ] || [ "$(readlink "$CHEZMOI_SOURCE")" != "$DOTFILES/home" ]; then
    echo "==> Linking chezmoi source to $DOTFILES/home"
    mkdir -p "$(dirname "$CHEZMOI_SOURCE")"
    if [ -e "$CHEZMOI_SOURCE" ] && [ ! -L "$CHEZMOI_SOURCE" ]; then
        mv "$CHEZMOI_SOURCE" "$CHEZMOI_SOURCE.bak.$(date +%s)"
    fi
    rm -f "$CHEZMOI_SOURCE"
    ln -s "$DOTFILES/home" "$CHEZMOI_SOURCE"
fi

# --- First-run chezmoi init (prompts for name/email/editor/machine) ---
if [ ! -f "$CHEZMOI_CONFIG" ]; then
    echo "==> Initializing chezmoi"
    chezmoi init
fi

# --- Persist brew shellenv in .bashrc so future bash shells find brew ---
if [ -x /opt/homebrew/bin/brew ]; then
    BREW_BIN=/opt/homebrew/bin/brew
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    BREW_BIN=/home/linuxbrew/.linuxbrew/bin/brew
fi
if [ -n "${BREW_BIN:-}" ] && ! grep -q "brew shellenv" "$HOME/.bashrc" 2>/dev/null; then
    echo "==> Adding brew shellenv to ~/.bashrc"
    {
        echo ''
        echo '# Homebrew — added by dotfiles/install.sh'
        echo "eval \"\$($BREW_BIN shellenv)\""
    } >> "$HOME/.bashrc"
fi

# --- Pre-install delta (used as chezmoi's diff pager during --verbose apply) ---
if ! command -v delta &>/dev/null; then
    echo "==> Installing git-delta (chezmoi diff pager)"
    brew install git-delta
fi

# --- Apply ---
echo "==> Applying chezmoi"
chezmoi apply --verbose

echo "==> Done. Run 'chezmoi status' any time to see drift."
