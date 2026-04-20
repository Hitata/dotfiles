# Homebrew via Brewfile

The Brewfile is chezmoi-managed at `home/dot_config/brew/Brewfile`, deployed to
`~/.config/brew/Brewfile`. A `run_onchange` hook runs `brew bundle` whenever the
file changes, so editing + `chezmoi apply` is the whole workflow.

## Edit and apply

```bash
nvim ~/dotfiles/home/dot_config/brew/Brewfile
cd ~/dotfiles && git add . && git commit -m "feat(brew): add <formula>"
chezmoi apply    # triggers brew bundle
```

## Manual commands

```bash
# Install everything listed in the Brewfile
brew bundle --file=~/.config/brew/Brewfile

# Check what's missing
brew bundle check --file=~/.config/brew/Brewfile

# Dump the current machine state into a Brewfile (starting point for a new host)
brew bundle dump --file=/tmp/Brewfile.dump

# Remove anything not in the Brewfile
brew bundle cleanup --file=~/.config/brew/Brewfile --force
```

## Searching

```bash
brew search font-          # fonts
brew search --cask <name>  # cask apps
```
