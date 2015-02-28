# ======== General ========
alias cl='clear'
alias _='sudo'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ll='ls -laFh'
alias l='ls -CF'

# ======== Directory ========
alias md='mkdir'
alias rd='rm -rf'


# ======== CPU ========
alias topC='top -o cpu' # cpu
alias topM='top -o vsize' #memory


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

rr() {
  find $1 -name "$2" -type f;
}

pg() {
  ps aux | grep $1
}

grep2() {
  grep -lZR "$1" | xargs -0 grep -l "$2"
}


# ======= Default Programs =========
alias text='open -a TextEdit'


# ======== Project Root Directories ========
alias ch='cd ~/Projects/coursehorse'
alias cha='cd ~/Projects/coursehorse-api'
alias chs='cd ~/Projects/coursehorse-solr'
alias mz='cd ~/Projects/mozy'
alias run='cd ~/Projects/runner'
alias aliases='open -a TextEdit ~/.me/.bash_aliases'

# ======== Daemons ========
alias php-fpm-stop='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php*.plist'
alias php-fpm-start='launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php*.plist'

alias mysqld-stop='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql*.plist'
alias mysqld-start='launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql*.plist'

alias nginx-stop='sudo launchctl unload -w /Library/LaunchAgents/homebrew.mxcl.nginx*.plist'
alias nginx-start='sudo launchctl load -w /Library/LaunchAgents/homebrew.mxcl.nginx*.plist'

alias rmq-start='sudo rabbitmq-server start'
alias rmq-stop='sudo rabbitmq-server stop'

alias solr-start='cd ~/Projects/coursehorse-solr/bin && bash daemon.sh start ../config/cmd.cfg'
alias solr-stop='cd ~/Projects/coursehorse-solr/bin && bash daemon.sh stop ../config/cmd.cfg'