#!/usr/bin/env bash

# Dotfiles
ln -sf ~/dotfiles/ackrc ~/.ackrc
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/editorconfig ~/.editorconfig
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/irbrc ~/.irbrc
ln -sf ~/dotfiles/pryrc ~/.pryrc
ln -sf ~/dotfiles/psqlrc ~/.psqlrc
ln -sf ~/dotfiles/rspec ~/.rspec
ln -sf ~/dotfiles/screenrc ~/.screenrc
ln -sf ~/dotfiles/sqliterc ~/.sqliterc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/zshrd ~/.zshrd

# ZSH Theme
ls -sf ~/dotfiles/zsh/travis.zsh-theme ~/.oh-my-zsh/themes/travis.zsh-theme

# Vim Theme
ln -sf ~/dotfiles/vim/railscasts.vim ~/.vim/colors/railscasts.vim
