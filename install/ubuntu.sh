#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# install packages (Ubuntu/Debian)
echo "$(tput setaf 2)> Installing packages...$(tput sgr 0)"

sudo apt-get update
sudo apt-get install -y git fzf bat jq

mkdir -p ~/.local/bin

# bat ships as `batcat` on Debian/Ubuntu; symlink so `bat` works everywhere
if [ ! -x ~/.local/bin/bat ] && [ -x "$(command -v batcat)" ]; then
  ln -sf "$(command -v batcat)" ~/.local/bin/bat
fi

# eza: apt doesn't carry it, use eza's official signed repo
# https://github.com/eza-community/eza/blob/main/INSTALL.md
if [ ! -x "$(command -v eza)" ]; then
  echo "$(tput setaf 2)> Installing eza...$(tput sgr 0)"
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt-get update
  sudo apt-get install -y eza
fi

# mise: official installer tracks releases faster than any apt repo
if [ ! -x "$(command -v mise)" ]; then
  echo "$(tput setaf 2)> Installing mise...$(tput sgr 0)"
  curl https://mise.run | sh
fi

# diff-so-fancy: no official apt package, ships on npm
if [ ! -x "$(command -v diff-so-fancy)" ]; then
  if [ -x "$(command -v npm)" ]; then
    echo "$(tput setaf 2)> Installing diff-so-fancy...$(tput sgr 0)"
    npm install -g diff-so-fancy
  else
    echo "$(tput setaf 3)> Skipping diff-so-fancy: npm not found. Install Node.js, then run: npm install -g diff-so-fancy$(tput sgr 0)"
  fi
fi

# starship
if [ ! -x "$(command -v starship)" ]; then
  echo "$(tput setaf 2)> Installing starship...$(tput sgr 0)"
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# mcfly
if [ ! -x "$(command -v mcfly)" ]; then
  echo "$(tput setaf 2)> Installing mcfly...$(tput sgr 0)"
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly
fi

# osxkeychain isn't available on Linux; devpods authenticate with a gh token instead
git config -f "$DOTFILES_DIR/gitconfig" --unset credential.helper 2>/dev/null || true

# devcontainer default statusLine command isn't present on this pod; use ccstatusline instead
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ -f "$CLAUDE_SETTINGS" ] && command -v jq >/dev/null; then
  echo "$(tput setaf 2)> Updating Claude statusLine command...$(tput sgr 0)"
  tmp_settings="$(mktemp)"
  jq '.statusLine.command = "npx -y ccstatusline@latest"' "$CLAUDE_SETTINGS" > "$tmp_settings" && mv "$tmp_settings" "$CLAUDE_SETTINGS"
fi
