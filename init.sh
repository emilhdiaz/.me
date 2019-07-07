#!/usr/bin/env bash

cd $HOME;
ln -s $HOME/.me/profile .profile;
ln -s $HOME/.me/bashrc .bashrc;
ln -s $HOME/.me/zshrc .zshrc;

ln -s $HOME/.me/git/gitconfig .gitconfig;
ln -s $HOME/.me/git/gitignore_global .gitignore_global;

# install zsh
# see: https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install GUIs
brew cask install \
  slack \
  spectacle \
  postman \
  intellij-idea \
  google-chrome \
  docker

# install common CLIs
brew install \
  git \
  direnv \
  dos2unix \
  jq

# install Python development tools
brew install \
  python3 \
  pyenv \
  pyenv-virtualenv


# install NodeJS development tools
brew install \
  node \
  npm \
  nvm

# install PHP development tools
brew install \
  php \
  composer

# install Ruby development tools
brew install \
  ruby \
  rvm

# install common cloud/deployment tools
brew install \
  awscli \
  google-cloud-sdk \
  packer \
  terraform \
  kubernetes-cli \
  kubernetes-helm

npm install -g \
  serverless
