# ======== Permissions & Configuration ========
alias _='sudo'
alias a='open -a TextEdit ~/.me/bash_aliases'
alias rc='open -a TextEdit ~/.me/.bashrc'
alias text='open -a TextEdit'

# ======== Navigation ========
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias cl='clear'
alias md='mkdir'
alias rd='rm -rf'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias fs='du -hc -d 1 | sort -nr'
alias p='cd $PROJECT_DIR'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hCF --color=auto'
    alias ll='ls -alhF --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
else 
    alias ls='ls -hCFG'
    alias ll='ls -alhFG'
fi


# ======== Resource Management ========
alias topC='top -o cpu' # cpu
alias topM='top -o vsize' #memory
alias top10='du -sx * | sort -rg | head -10'

# Add an "alert" alias for long running commands.  Use like so $> sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
  $HOME/cloud_sql_proxy -instances=$1:us-east1:$2=tcp:3308
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
    mkdir -p "$1" && cd "$1" && 	# passing `-p` means it doesn't fail if the dir exists
    pyenv virtualenv "$2" "$1"-"$2" &&  # create the new virtualenv
    pyenv local "$1"-"$2" &&  		# set the new virtualenv to be the local Python version
    pip install -U pip setuptools &&	# upgrade pip and setuptools
    [ -e "requirements.txt" ] &&  	# check if requirements.txt exists...
    pip install -r requirements.txt  	# ...and if it does, install it
}
