# Ubuntu PC Setup

Step-by-step record of setting up this machine. Run as the primary user (`ze-tank`).

## 1. Base packages

```bash
sudo apt update
sudo apt install -y curl git
```

## 2. Terminal / shell stack

```bash
sudo apt install -y fish tmux neovim fzf
```

Set fish as the default login shell:

```bash
chsh -s /usr/bin/fish
```

Log out and back in, then verify with `echo $SHELL`.

## 3. Passwordless sudo (optional)

Used on this machine to drop the sudo password prompt:

```bash
sudo passwd -d ze-tank   # remove login password
sudo visudo              # add: ze-tank ALL=(ALL) NOPASSWD:ALL
```

## 4. Claude Code

```bash
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
claude -v
```

## 5. GitHub CLI

```bash
sudo apt install -y gh
gh auth login
```

## 6. Cloudflared

APT repo route:

```bash
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
  | sudo tee /usr/share/keyrings/cloudflare-main.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" \
  | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt-get update
sudo apt-get install -y cloudflared
```

Or, if installing from a downloaded `.deb`:

```bash
sudo dpkg -i ~/Downloads/cloudflared-linux-amd64.deb
```

## 7. Node.js via fnm

```bash
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm install 20
fnm use 20
```

## 8. Brave browser

```bash
curl -fsS https://dl.brave.com/install.sh | sh
```

## 9. Dotfiles

Clone and link/apply as needed (see `README.md` and `Makefile` in `~/dotfiles`).
