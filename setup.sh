#!/usr/bin/env bash

# install homebrew
if [ ! -x "$(command -v brew)" ]; then
  echo "$(tput setaf 2)> Installing homebrew...$(tput sgr 0)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "$(tput setaf 2)> Installing oh-my-zsh...$(tput sgr 0)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install homebrew packages
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

# ensure .config directory
mkdir -p ~/.config

# link dotfiles
echo "$(tput setaf 2)> Linking dotfiles...$(tput sgr 0)"
ln -sf ~/sites/dotfiles/ackrc ~/.ackrc
ln -sf ~/sites/dotfiles/bashrc ~/.bashrc
ln -sf ~/sites/dotfiles/editorconfig ~/.editorconfig
ln -sf ~/sites/dotfiles/gemrc ~/.gemrc
ln -sf ~/sites/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/sites/dotfiles/irbrc ~/.irbrc
ln -sf ~/sites/dotfiles/pryrc ~/.pryrc
ln -sf ~/sites/dotfiles/psqlrc ~/.psqlrc
ln -sf ~/sites/dotfiles/rspec ~/.rspec
ln -sf ~/sites/dotfiles/screenrc ~/.screenrc
ln -sf ~/sites/dotfiles/sqliterc ~/.sqliterc
ln -sf ~/sites/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/sites/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/sites/dotfiles/vimrc ~/.vimrc
ln -sf ~/sites/dotfiles/zshrc ~/.zshrc

# link Ghostty config
mkdir -p ~/.config/ghostty
ln -sf ~/sites/dotfiles/config.ghostty ~/.config/ghostty/config.ghostty

# link ZSH theme
ln -sf ~/sites/dotfiles/zsh/travis.zsh-theme ~/.oh-my-zsh/themes/travis.zsh-theme

# link vim theme
mkdir -p ~/.vim/colors
ln -sf ~/sites/dotfiles/vim/railscasts.vim ~/.vim/colors/railscasts.vim
