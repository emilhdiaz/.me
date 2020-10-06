pynew() {
  mkdir -p "$1" && cd "$1" && # passing `-p` means it doesn't fail if the dir exists
    pyenv virtualenv "$2" "$1"-"$2" && # create the new virtualenv
    pyenv local "$1"-"$2" && # set the new virtualenv to be the local Python version
    pip3 install -U pip setuptools && # upgrade pip and setuptools
    [ -e "requirements.txt" ] && # check if requirements.txt exists...
    pip3 install -r requirements.txt # ...and if it does, install it
}
