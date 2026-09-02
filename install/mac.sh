#!/usr/bin/env bash

# install homebrew
if [ ! -x "$(command -v brew)" ]; then
  echo "$(tput setaf 2)> Installing homebrew...$(tput sgr 0)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
