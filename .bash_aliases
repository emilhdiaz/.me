# some more ls aliases
alias ll='ls -alFh'
alias l='ls -CF'

rr() {
  find $1 -name "$2" -type f;
}

grep2() {
  grep -lZR "$1" | xargs -0 grep -l "$2"
}
