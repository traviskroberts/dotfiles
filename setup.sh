#!/usr/bin/env bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install homebrew packages
brew install git exa bat asdf
brew install michaeldfallen/formula/git-radar

# link dotfiles
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
ln -sf ~/sites/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/sites/dotfiles/vimrc ~/.vimrc
ln -sf ~/sites/dotfiles/zshrc ~/.zshrc

# link ZSH theme
ln -sf ~/sites/dotfiles/zsh/travis.zsh-theme ~/.oh-my-zsh/themes/travis.zsh-theme

# link vim theme
ln -sf ~/sites/dotfiles/vim/railscasts.vim ~/.vim/colors/railscasts.vim
