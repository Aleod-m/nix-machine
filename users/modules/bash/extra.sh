export LS_COLORS='auto'

alias lessc='less -r'

ssha() {
    key_file="$HOME/.ssh/$1" 
    if [[ ! -f "$key_file" ]]; then 
        echo "ssh key not found"
    else
        ssh-add "$key_file"
    fi
}

up() {
    if ! command -v sed 1>/dev/null 2>&1 
    then
        echo "The up command needs sed on the system."
        return 1
    fi
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++)) do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd "$d" || echo "Cannot go higher."
}

mkcd() {
    mkdir "$1"; cd "$1" || return 
}

sshexec() {
    if ! command -v ssh 1>/dev/null 2>&1 
    then
        echo "The up command needs nvim on the system."
        return
    fi
    host=$1 && shift;
    ssh -t "$host" -o RemoteCommand=none -- "$@"
}

nvl() {
    if ! command -v nvim 1>/dev/null 2>&1 
    then
        echo "The up command needs nvim on the system."
        return
    fi
    if [[ $# -lt 1 ]];
    then
        echo "Needs at least the pipe name to listen to."
        return
    fi
    pipe_name=$1 && shift;
    nvim --listen "/tmp/nvim.{$pipe_name}.pipe" "$@"
}

nvs() {
    if ! command -v nvim 1>/dev/null 2>&1
    then
        echo "The up command needs nvim on the system."
        return;
    fi
    if [[ $# -lt 1 ]];
    then
        echo "Needs an argument."
        return
    fi
    pipe_name=$1; shift;
    nvim --server "/tmp/nvim.{$pipe_name}.pipe"
}

git_sparse_clone() {
  rurl="$1" localdir="$2" && shift 2;

  mkdir -p "$localdir"
  cd "$localdir" || return

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
}

source $HOME/.profile
