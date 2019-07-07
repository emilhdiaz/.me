#!/usr/bin/env bash

cd $HOME;
ln -s $HOME/.me/profile .profile;
ln -s $HOME/.me/bashrc .bashrc;
ln -s $HOME/.me/zshrc .zshrc;

ln -s $HOME/.me/git/gitconfig .gitconfig;
ln -s $HOME/.me/git/gitignore_global .gitignore_global;

brew bundle --file=$HOME/.me/Brewfile

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
npm install -g serverless
