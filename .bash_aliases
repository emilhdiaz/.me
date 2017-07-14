# ======== General ========
alias cl='clear'
alias _='sudo'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ll='ls -laFh'
alias l='ls -CF'
alias fs='du -hc -d 1 | sort -nr'
alias text='open -a TextEdit'
alias a='open -a TextEdit ~/.me/.bash_aliases'

# ======== Directory ========
alias md='mkdir'
alias rd='rm -rf'

# ======== CPU ========
alias topC='top -o cpu' # cpu
alias topM='top -o vsize' #memory
alias top10='du -sx * | sort -rg | head -10'

# ======== Functions ========
cgi() {
  DOCUMENT_ROOT=/Users/emil/Projects/coursehorse/public \
  SCRIPT_NAME=/index.php \
  SCRIPT_FILENAME=/Users/emil/Projects/coursehorse/public/index.php \
  DOCUMENT_URI=/index.php \
  REQUEST_URI=$1?XDEBUG_SESSION_START=$2 \
  REQUEST_METHOD=GET \
  QUERY_STRING=XDEBUG_SESSION_START=$2 \
  HTTP_HOST=coursehorse.localhost \
  cgi-fcgi -bind -connect /usr/local/var/run/php5-fpm.sock
}

cloudsql() {
  /Users/emil/cloud_sql_proxy -instances=chicory-$1:us-east1:chicory-$2=tcp:3308'
}

kill_all() {
  for pid in $(ps -ef | grep "$1" | awk '{print $2}'); do kill -9 $pid; done
}

fd_review() {
  for pid in `pidof $1`; do echo "PID: $pid - $(< /proc/$pid/cmdline)"; egrep 'files|Limit' /proc/$pid/limits; echo "Currently open files: $(ls -1 /proc/$pid/fd | wc -l)"; echo; done
}

socket_review() {
  netstat -ton| grep WAIT | grep $1 | wc -l
}

rr() {
  find $1 -name "$2" -type f;
}

pg() {
  ps aux | grep $1
}

grep2() {
  grep -lZR "$1" | xargs -0 grep -l "$2"
}

quote() {
  ruby -rcsv -ne 'puts CSV.generate_line(CSV.parse_line($_), :force_quotes=>true)' $1
}

function pynew() {
    mkdir -p "$1" && cd "$1" &&  # passing `-p` means it doesn't fail if the dir exists
    pyenv virtualenv "$2" "$1"-"$2" &&  # create the new virtualenv
    pyenv local "$1"-"$2" &&  # set the new virtualenv to be the local Python version
    pipup &&
    [ -e "requirements.txt" ] &&  # check if requirements.txt exists...
    pip install -r requirements.txt  # ...and if it does, install it
}
