#!/usr/bin/env zsh

SHELL_NAME="$(basename "$SHELL")"

(
  cd "$HOME" && \
  ln -sf "$HOME/.me/shell/profile" "$HOME/.profile";
  ln -sf "$HOME/.me/shell/bashrc" "$HOME/.bashrc";
  ln -sf "$HOME/.me/shell/zshrc" "$HOME/.zshrc";
  ln -sf "$HOME/.me/git/gitconfig" "$HOME/.gitconfig";
  ln -sf "$HOME/.me/git/gitignore_global" "$HOME/.gitignore_global";
)

source "$HOME/.${SHELL_NAME}rc"

adt install --config adt-config.yml
