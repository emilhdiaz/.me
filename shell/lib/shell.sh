get_shell_rc_file() {
  : <<DOC
Determine the appropriate init script for your default interactive shell
--------------------------------------------------------------------------------
DOC
  set +eu
  local RC_FILE="$HOME/.bash_profile"
  if [ -f "$HOME/.rc" ]; then
    RC_FILE="$HOME/.rc"
  elif [ -n "$BASH_VERSION" ]; then
    RC_FILE="$HOME/.bashrc"
  elif [ -n "$ZSH_VERSION" ]; then
    RC_FILE="$HOME/.zshrc"
  fi
  touch ${RC_FILE}
  echo ${RC_FILE}
  set -eu
  return 0
}

print_path() {
  IFS=':' read -rA PATH_ARRAY <<< "$PATH"

  for i in "${PATH_ARRAY[@]}"
  do
    echo $i
  done
}
