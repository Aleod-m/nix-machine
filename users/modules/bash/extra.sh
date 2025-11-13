export LS_COLORS='auto'

alias lessc='less -r'

_check_cmd() {
    if ! command -v "$2" 1>/dev/null 2>&1; then 
        echo "The $2 function needs $1 on the system";
        return 1
    fi
    return 0
}

keya() {
    _check_cmd "keya" "ssh-add" || return;
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        eval "$(ssh-agent)";
    fi
    key_file="$HOME/.ssh/$1" 
    if [[ ! -f "$key_file" ]]; then 
        echo "ssh key not found"
    else
        ssh-add "$key_file"
    fi
}

_keya_completion() {
    local key_dir="$HOME/.ssh";
    local curr prev;
    COMPREPLY=();
    curr="${COMP_WORDS[COMP_CWORD]}";
    prev="${COMP_WORDS[COMP_CWORD-1]}";
    if [[ ${prev} == "keya" ]]; then
        mapfile -t COMPREPLY < <(compgen -f -- "$key_dir/$curr" \
            | cut -c"$(echo "${key_dir}/" | wc -c)"- \
            | grep -v -e ".*\.pub" -e "known_host" -e "config" \
        );
    fi
}

complete -F _keya_completion keya


up() {
    _check_cmd "up" "sed" || return;
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

ssh-exec() {
    _check_cmd "ssh-exec" "ssh" || return
    if ! command -v ssh 1>/dev/null 2>&1 
    then
        echo "The up command needs nvim on the system."
        return
    fi
    host=$1 && shift;
    ssh -t "$host" -o RemoteCommand=none -- "$@"
}

nvl() {
    _check_cmd "nvl" "nvim" || return;
    if [[ $# -lt 1 ]];
    then
        echo "Needs at least the pipe name to listen to."
        return
    fi
    pipe_name=$1 && shift;
    nvim --listen "/tmp/nvim.{$pipe_name}.pipe" "$@"
}

nvs() {
    _check_cmd "nvs" "nvim" || return;
    if [[ $# -lt 1 ]];
    then
        echo "Needs an argument."
        return
    fi
    pipe_name=$1; shift;
    nvim --server "/tmp/nvim.{$pipe_name}.pipe"
}

lt() {
    _check_cmd "lt" "eza";
    local level="$1"
    if [[ "$level" =~ ^[0-9]+$ ]]; then
        eza --tree --level "$1" --git-ignore --sort extension;
    fi
}

PATH="$PATH:/$HOME/bin"

source "$HOME/.profile"
