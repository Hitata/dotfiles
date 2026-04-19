#!/usr/bin/env bash
# bttb-new-pc-setup.sh — run on the new PC after copying bttb-secrets.tar.gz here.
#
# Usage:
#   chmod +x bttb-new-pc-setup.sh
#   ./bttb-new-pc-setup.sh
#
# Assumes: bttb-secrets.tar.gz sits next to this script in ~ (or the current dir).

set -euo pipefail

SECRETS_TARBALL="${SECRETS_TARBALL:-$HOME/bttb-secrets.tar.gz}"
DOTFILES_REPO="git@github.com:Hitata/dotfiles.git"
PROJECT_REPO="git@github.com:Hitata/bttb.git"
PROJECT_DIR="$HOME/Sites/bttb"
NODE_VERSION="24.14.0"

step() { echo ""; echo "── $* ──"; }
ok()   { echo "  ✓ $*"; }
skip() { echo "  · skip: $*"; }

# ─── 1. Secrets (SSH keys, .env, cloudflared, gitconfig) ───────────────
step "1/6 · Extracting secrets tarball"
if [[ ! -f "$SECRETS_TARBALL" ]]; then
  echo "  ✗ tarball not found at $SECRETS_TARBALL"
  echo "    Copy bttb-secrets.tar.gz here first, then rerun."
  exit 1
fi
if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
  skip "$HOME/.ssh/id_ed25519 already exists — not overwriting"
else
  tar xzf "$SECRETS_TARBALL" -C /
  chmod 700 "$HOME/.ssh"
  chmod 600 "$HOME/.ssh/id_ed25519"
  chmod 644 "$HOME/.ssh/id_ed25519.pub"
  ok "secrets extracted, ssh perms set"
fi

# ─── 2. Dotfiles (Claude config + memory) ──────────────────────────────
step "2/6 · Cloning dotfiles + running 'make claude'"
if [[ -d "$HOME/dotfiles/.git" ]]; then
  skip "$HOME/dotfiles already cloned"
else
  git clone "$DOTFILES_REPO" "$HOME/dotfiles"
  ok "dotfiles cloned"
fi
if command -v stow >/dev/null 2>&1; then
  (cd "$HOME/dotfiles" && make claude)
  ok "claude stow linked"
else
  echo "  ⚠ 'stow' not installed — run 'brew install stow' (or apt install stow), then:"
  echo "    cd ~/dotfiles && make claude"
fi

# ─── 3. Project repo ──────────────────────────────────────────────────
step "3/6 · Cloning bttb project"
if [[ -d "$PROJECT_DIR/.git" ]]; then
  skip "$PROJECT_DIR already cloned"
else
  mkdir -p "$(dirname "$PROJECT_DIR")"
  git clone "$PROJECT_REPO" "$PROJECT_DIR"
  ok "bttb cloned"
fi
# Tarball extracted .env into $PROJECT_DIR/.env already — verify it's there.
if [[ -f "$PROJECT_DIR/.env" ]]; then
  ok ".env in place"
else
  echo "  ⚠ $PROJECT_DIR/.env missing — check tarball contents"
fi

# ─── 4. Node + deps ───────────────────────────────────────────────────
step "4/6 · Installing Node $NODE_VERSION and running npm install"
if command -v nvm >/dev/null 2>&1 || [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.nvm/nvm.sh" 2>/dev/null || true
  nvm install "$NODE_VERSION"
  nvm use "$NODE_VERSION"
  ok "node $NODE_VERSION active (via nvm)"
elif command -v volta >/dev/null 2>&1; then
  volta install "node@$NODE_VERSION"
  ok "node $NODE_VERSION active (via volta)"
else
  echo "  ⚠ neither nvm nor volta found — install one, then:"
  echo "    nvm install $NODE_VERSION && nvm use $NODE_VERSION"
fi
(cd "$PROJECT_DIR" && npm install)
ok "npm install complete"

# ─── 5. Supabase CLI link ─────────────────────────────────────────────
step "5/6 · Supabase link"
if grep -qE '^SUPABASE_PROJECT_REF=' "$PROJECT_DIR/.env" 2>/dev/null; then
  REF=$(grep -E '^SUPABASE_PROJECT_REF=' "$PROJECT_DIR/.env" | head -1 | cut -d= -f2 | tr -d '"')
  (cd "$PROJECT_DIR" && npx supabase link --project-ref "$REF") && ok "linked to $REF"
else
  echo "  ⚠ SUPABASE_PROJECT_REF not found in .env — run manually:"
  echo "    cd $PROJECT_DIR && npx supabase link --project-ref <ref>"
fi

# ─── 6. Cloudflared tunnel ────────────────────────────────────────────
step "6/6 · Cloudflared tunnel"
if command -v cloudflared >/dev/null 2>&1; then
  TUNNEL=$(grep -E '^tunnel:' "$HOME/.cloudflared/config.yml" 2>/dev/null | awk '{print $2}')
  if [[ -n "${TUNNEL:-}" ]]; then
    echo "  tunnel configured: $TUNNEL"
    echo "  to start: cloudflared tunnel run $TUNNEL"
  else
    echo "  ⚠ couldn't parse tunnel name from ~/.cloudflared/config.yml"
  fi
else
  echo "  ⚠ cloudflared not installed — install it, then:"
  echo "    cloudflared tunnel run <tunnel-name>"
fi

echo ""
echo "─────────────────────────────────────────"
echo "Done. Next:"
echo "  cd $PROJECT_DIR && npm run dev"
echo "  Then delete $SECRETS_TARBALL on BOTH machines."
echo "─────────────────────────────────────────"
