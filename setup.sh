#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "$(tput setaf 2)> Installing oh-my-zsh...$(tput sgr 0)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install packages (macOS via Homebrew, Ubuntu via apt/official installers)
if [ "$(uname -s)" = "Darwin" ]; then
  bash "$DOTFILES_DIR/install/mac.sh"
else
  bash "$DOTFILES_DIR/install/ubuntu.sh"
fi

# ensure .config directory
mkdir -p ~/.config

# link dotfiles
echo "$(tput setaf 2)> Linking dotfiles...$(tput sgr 0)"
ln -sf "$DOTFILES_DIR/ackrc" ~/.ackrc
ln -sf "$DOTFILES_DIR/bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/editorconfig" ~/.editorconfig
ln -sf "$DOTFILES_DIR/gemrc" ~/.gemrc
ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/irbrc" ~/.irbrc
ln -sf "$DOTFILES_DIR/pryrc" ~/.pryrc
ln -sf "$DOTFILES_DIR/psqlrc" ~/.psqlrc
ln -sf "$DOTFILES_DIR/rspec" ~/.rspec
ln -sf "$DOTFILES_DIR/screenrc" ~/.screenrc
ln -sf "$DOTFILES_DIR/sqliterc" ~/.sqliterc
ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc

# link Ghostty config
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/config.ghostty" ~/.config/ghostty/config.ghostty

# link ccstatusline config
mkdir -p ~/.config/ccstatusline
ln -sf "$DOTFILES_DIR/ccstatusline-settings.json" ~/.config/ccstatusline/settings.json

# link ZSH theme
ln -sf "$DOTFILES_DIR/zsh/travis.zsh-theme" ~/.oh-my-zsh/themes/travis.zsh-theme

# link vim theme
mkdir -p ~/.vim/colors
ln -sf "$DOTFILES_DIR/vim/railscasts.vim" ~/.vim/colors/railscasts.vim
