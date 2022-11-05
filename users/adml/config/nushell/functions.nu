def-env up [nb: int = 1] {
    let path = (1..$nb | each {|_| ".."} | reduce {|it, acc| $acc + "/" + $it})
    cd $path 
}

def-env mkcd [name: path] {
    cd (mkdir $name -s | first)
}

def-env fix-kbd [] {
    setxkbmap fr-workman-p -option caps:swapescape
}

def set-screen [side: string = "right"] {
    if $side == "right" {
        xrandr --output HDMI-2 --auto --right-of eDP-1 
    } else if $side == "left" {
        xrandr --output HDMI-2 --auto --left-of eDP-1 
    } else {
        print "Side argument should be either \"right\" or \"left\"."
    }
}

def nixDev [] {
    nix develop -c $env.SHELL
}
def nixDevi [] {
    nix develop --impure -c $env.SHELL
}

alias nv = nvim
alias la = ls -a
alias ll = ls -l

def gcm [message: string] {
    git commit -m $message
}

alias gs = git status

def loc [p: path] {
    ls ($p + /**/*) | where type == file | get name | each {|it| open $it | lines | length } | reduce {|a, b| $a + $b}
}

def mkmod [p:path] {
    cd (mkdir $p -s | first)
    touch mod.rs
}
