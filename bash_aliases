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
alias topC='top -o cpu'   # cpu
alias topM='top -o vsize' #memory
alias top10='du -sx * | sort -rg | head -10'

# Add an "alert" alias for long running commands.  Use like so $> sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
