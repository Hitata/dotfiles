# Ubuntu Setup

Bootstrap an Ubuntu machine from scratch. Packages + extras are managed declaratively via chezmoi (see `home/dot_config/{apt,snap}/packages.txt`).

## 1. Keyboard — Caps→Ctrl

```bash
sudo vi /etc/default/keyboard
# set XKBOPTIONS="ctrl:nocaps"
sudo dpkg-reconfigure keyboard-configuration
```

## 2. SSH key for GitHub

```bash
ssh-keygen -t ed25519 -C "tranhoangtrung.nob@gmail.com"
cat ~/.ssh/id_ed25519.pub
# add to https://github.com/settings/keys
```

## 3. Passwordless sudo (optional)

```bash
sudo visudo
# append: <user> ALL=(ALL) NOPASSWD:ALL
```

## 4. Bootstrap chezmoi + dotfiles

```bash
sudo apt update && sudo apt install -y curl git
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Hitata
```

`chezmoi apply` fires the run_onchange hooks in order:
- `install-apt.sh` — installs everything in `~/.config/apt/packages.txt`
- `install-snap.sh` — installs everything in `~/.config/snap/packages.txt`
- `install-ubuntu-extras.sh` — fnm, pnpm, Claude Code, Brave, cloudflared (curl-bash installers)
- `install-nvim-plugins.sh` — packer + PackerSync
- `install-npm-globals.sh` — global node tools

## 5. Set fish as default shell

```bash
chsh -s /usr/bin/fish
# log out, log back in, verify: echo $SHELL
```

## Adding a package later

- **apt**: edit `home/dot_config/apt/packages.txt`, commit, `chezmoi apply` re-runs `apt install`
- **snap**: same but in `snap/packages.txt` (supports `--classic` flag per line)
- **curl-bash installer**: add another step to `home/run_once_after_install-ubuntu-extras.sh.tmpl` with a `command -v` idempotency guard
