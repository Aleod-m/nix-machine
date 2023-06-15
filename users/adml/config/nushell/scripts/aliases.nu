
alias nv = nvim
alias vim = nvim

alias la = ls -a
alias ll = ls -l
alias ld = ls --du

# be more verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mv = mv --verbose


# Git aliases.
alias gs = git status
# Commit with message.
def gcm [message: string] {
    git commit -m $message
}

# Checkout to branch.
def gco [branch] {
    git checkout $branch
}

# Add a path 
def ga [...path: string] {
    git add $path
}

# Add all changes. 
def gA [] {
    git add --all
}
