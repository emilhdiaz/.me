git-check() {
  DIR=$1
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && git st" \; 2>/dev/null
}

git-check-tracked() {
  DIR=$1
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && git st --untracked-file=no" \; 2>/dev/null
}

git-branch() {
  DIR=$1
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && git br" \; 2>/dev/null
}

git-pull() {
  DIR=$1
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && git pull" \; 2>/dev/null
}

git-push() {
  DIR=$1
  DEPTH=${2:-0}
  find ${DIR}/* -maxdepth ${DEPTH} -type d ! -name . -exec bash -c "cd '{}' && pwd && git push" \; 2>/dev/null
}

git-change-author() {

  git filter-branch --env-filter '

        OLD_EMAIL=${1}
        CORRECT_NAME=${2}
        CORRECT_EMAIL=${3}

        if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]; then
            export GIT_COMMITTER_NAME="$CORRECT_NAME"
            export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
        fi

        if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]; then
            export GIT_AUTHOR_NAME="$CORRECT_NAME"
            export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
        fi

    ' --tag-name-filter cat -- --branches --tags
}
