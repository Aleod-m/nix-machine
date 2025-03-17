export LS_COLORS='auto'

alias lessc='less -r'

up() {
    if ! command -v sed 2>&1 > /dev/null
    then
        echo "The up command needs sed on the system."
        exit 1
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
    cd $d
}

mkcd() {
    mkdir $1; cd $1
}

sshexec() {
    if ! command -v ssh 2>&1 > /dev/null 
    then
        echo "The up command needs nvim on the system."
        exit 1
    fi
    host=$1; shift
    ssh -t $host -o RemoteCommand=none -- $@
}

nvl() {
    if ! command -v nvim 2>&1 > /dev/null
    then
        echo "The up command needs nvim on the system."
        exit 1
    fi
    nvim --listen "/tmp/nvim.{$pipe_name}.pipe"
}

nvs() {
    if ! command -v nvim 2>&1 > /dev/null
    then
        echo "The up command needs nvim on the system."
        exit 1
    fi
    nvim --server "/tmp/nvim.{$pipe_name}.pipe"
}

function git_sparse_clone() (
  rurl="$1" localdir="$2" && shift 2

  mkdir -p "$localdir"
  cd "$localdir"

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
)

function gwc() {
    git worktree add "../$1" -B "$1"
}
