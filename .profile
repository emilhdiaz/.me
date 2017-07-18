# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes /usr/local bin if it exists
if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:$PATH"
fi

# set PATH so it includes /usr/local sbin if it exists
if [ -d "/usr/local/sbin" ] ; then
    PATH="/usr/local/sbin:$PATH"
fi

# set PATH so it includes android sdk platform tools
if [ -d "/usr/local/android-sdk-macosx/platform-tools" ] ; then
    PATH="/usr/local/android-sdk-macosx/platform-tools:$PATH"
fi

# set PATH so it includes android sdk tools
if [ -d "/usr/local/android-sdk-macosx/tools" ] ; then
    PATH="/usr/local/android-sdk-macosx/tools:$PATH"
fi

# set PATH so that it includes Heroku Toolbelt
if [ -d "/usr/local/heroku/bin" ] ; then
    PATH="/usr/local/heroku/bin:$PATH"
fi

# set PATH so that it includes composer bin
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# set PATH so that it includes rvm bin
if [ -d "$HOME/.rvm/bin" ] ; then
    PATH="$HOME/.rvm/bin:$PATH"
fi

## Activate NVM
if [ -d "/usr/local/opt/nvm" ] ; then
    export NVM_DIR="/usr/local/opt/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  			# This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"	# This loads nvm bash_completion
fi

## Activate PYENV
if [ -e "/usr/local/bin/pyenv" ] ; then
    eval "$(pyenv init -)"
fi

## Activate DIRENV
if [ -e "/usr/local/bin/direnv" ] ; then
    eval "$(direnv hook $0)"
fi

## Activate Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then 
    source "$HOME/google-cloud-sdk/path.bash.inc"; 
fi

## Activate gcloud CLI
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then 
    source "$HOME/google-cloud-sdk/completion.bash.inc"; 
fi

export PATH=$PATH
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR="/usr/bin/vi"
export CHICORY_HOME="$HOME/Projects"
