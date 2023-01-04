
alias nv = nvim
alias vim = nvim

alias la = ls -a
alias ll = ls -l
alias ld = ls -du

# be more verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mv = mv --verbose


# Git aliases
alias gs = git status
def gcm [message: string] {
    git commit -m $message
}


def gco [branch] {
    git checkout $branch
}

def ga [...path: string] {
    git add $path
}

def gA [] {

}