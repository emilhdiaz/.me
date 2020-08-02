## Activate DIRENV
if [ -e "/usr/local/bin/direnv" ] ; then
    eval "$(direnv hook $SHELL)";
    eval "$(direnv hook bash)";
fi