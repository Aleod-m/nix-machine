alias nv = nvim
alias la = ls -a
alias ll = ls -l
alias ld = ls --du

# Nix aliases
alias nf = nix flake
alias ns = nix store 
alias nr = nix registry

def "nr list" [] {
    nix registry list | parse "{type} flake:{name} {pathtype}:{path}"
        | update type { $in | str trim }
}

def "nr update" [] {
    $in | each { nr pin $in.name $"($in.pathtype):($in.path)" }
}

# be more verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mv = mv --verbose


# Git aliases.
alias gs = git status
alias gd = git diff 
alias gl = git log --oneline

def nvl [pipe_name: string] {
    nvim --listen $"/tmp/nvim.($pipe_name).pipe"
}

def nvs [pipe_name: string] {
    nvim --server $"/tmp/nvim.($pipe_name).pipe"
}

# Commit with message.
def gcm [message: string] {
    git commit -m $message
}

def gca [message: string] {
    git commit --amend -m $message
}

# Checkout to branch.
def gco [branch] {
    git checkout $branch
}

# Add a path 
def ga [...path: string] {
    git add ...$path
}

# Add all changes. 
def gA [] {
    git add --all
}

alias reset-env-scripts = rmdir ~/.config/nushell/gen
