#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install homebrew (macOS only)
if [ "$(uname -s)" = "Darwin" ]; then
  if [ ! -x "$(command -v brew)" ]; then
    echo "$(tput setaf 2)> Installing homebrew...$(tput sgr 0)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "$(tput setaf 2)> Installing oh-my-zsh...$(tput sgr 0)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install homebrew packages (macOS only)
if [ "$(uname -s)" = "Darwin" ]; then
  echo "$(tput setaf 2)> Installing homebrew packages...$(tput sgr 0)"
  brew list git &>/dev/null || brew install git
  brew list eza &>/dev/null || brew install eza
  brew list bat &>/dev/null || brew install bat
  brew list mise &>/dev/null || brew install mise
  brew list diff-so-fancy &>/dev/null || brew install diff-so-fancy
  brew list fzf &>/dev/null || brew install fzf
  brew list starship &>/dev/null || brew install starship
  brew tap cantino/mcfly
  brew list mcfly &>/dev/null || brew install mcfly
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

# link ZSH theme
ln -sf "$DOTFILES_DIR/zsh/travis.zsh-theme" ~/.oh-my-zsh/themes/travis.zsh-theme

# link vim theme
mkdir -p ~/.vim/colors
ln -sf "$DOTFILES_DIR/vim/railscasts.vim" ~/.vim/colors/railscasts.vim
