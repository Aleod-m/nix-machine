export LS_COLORS='auto'

alias lessc='less -r'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

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
    mkdir $1
    cd $1
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
