#!/usr/bin/env bash

cd $HOME;
ln -s $HOME/.me/profile .profile;
ln -s $HOME/.me/bashrc .bashrc;
ln -s $HOME/.me/zshrc .zshrc;

ln -s $HOME/.me/git/gitconfig .gitconfig;
ln -s $HOME/.me/git/gitignore_global .gitignore_global;

# install GUIs
brew cask install \
  slack \
  spectacle \
  postman \
  intellij-idea \
  google-chrome \
  docker

# install CLIs
brew install \
  awscli \
  direnv \ 
  dos2unix \ 
  git \ 
  jq \ 
  node \ 
  packer \ 
  terraform \
  kubernetes-cli \
  pyenv \ 
  pyenv-virtualenv
  python3


npm install -g \
  serverless
