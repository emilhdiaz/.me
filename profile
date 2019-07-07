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

## Activate (PHP) Composer
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    PATH="$HOME/.composer/vendor/bin:$PATH"
fi

## Activate (Ruby) RVM
if [ -d "$HOME/.rvm/bin" ] ; then
    PATH="$HOME/.rvm/bin:$PATH"
fi

## Activate (NodeJS) NVM
if [ -d "/usr/local/opt/nvm" ] ; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
fi

## Activate (Python) PYENV
if [ -e "/usr/local/bin/pyenv" ] ; then
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)";
fi

## Activate DIRENV
if [ -e "/usr/local/bin/direnv" ] ; then
    eval "$(direnv hook $SHELL)";
    eval "$(direnv hook bash)";
fi

## Activate Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
    source "$HOME/google-cloud-sdk/path.bash.inc";
fi

## Activate gcloud CLI
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.bash.inc";
fi

## Activate Hyper Ledger Fabric examples
if [ -d "$HOME/Projects/fabric-samples/bin" ] ; then
    PATH="$HOME/Projects/fabric-samples/bin:$PATH"
fi
