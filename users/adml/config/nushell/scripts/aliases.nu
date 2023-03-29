
old-alias nv = nvim
old-alias vim = nvim

old-alias la = ls -a
old-alias ll = ls -l
old-alias ld = ls --du

# be more verbose
old-alias cp = cp --verbose
old-alias rm = rm --verbose
old-alias mv = mv --verbose


# Git aliases
old-alias gs = git status
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
    git add --all
}
