#!/usr/bin/env bash

cd $HOME;
ln -s $HOME/.me/profile $HOME/.profile;
ln -s $HOME/.me/bashrc $HOME/.bashrc;
ln -s $HOME/.me/zshrc $HOME/.zshrc;
ln -s $HOME/.me/rc $HOME/.rc;

ln -s $HOME/.me/git/gitconfig $HOME/.gitconfig;
ln -s $HOME/.me/git/gitignore_global $HOME/.gitignore_global;

# ======== Install Programs ========

brew bundle --file=$HOME/.me/Brewfile

if [ -d ~/.me/programs ]; then
    for f in ~/.me/programs/*; do
        source "${f}" --install;
    done
fi