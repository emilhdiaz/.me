kill_all() {
  for pid in $(ps -ef | grep "$1" | awk '{print $2}'); do kill -9 $pid; done
}

fd_review() {
  for pid in $(pidof $1); do
    echo "PID: $pid - $(</proc/$pid/cmdline)"
    egrep 'files|Limit' /proc/$pid/limits
    echo "Currently open files: $(ls -1 /proc/$pid/fd | wc -l)"
    echo
  done
}

socket_review() {
  netstat -ton | grep WAIT | grep $1 | wc -l
}

pg() {
  ps aux | grep $1
}
