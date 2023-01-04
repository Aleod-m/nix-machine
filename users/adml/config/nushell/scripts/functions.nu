# Various directories helpers.
export def-env up [nb: int = 1] {
    let path = ( 1..$nb | each { |_| ".." } | reduce { |it, acc| $acc + "/" + $it } )
    cd $path 
}

export def-env mkcd [name: path] {
    cd ( mkdir $name | first )
}


# Fix my keyboard layout. TODO: remove once kmonad is set up.
export def-env fix-kbd [] {
    (setxkbmap -layout us -variant workman -option caps:swapescape)
}

export def set-screen [side: string = "right"] {
    if $side == "right" {
        ^xrandr --output HDMI-2 --auto --right-of eDP-1 
    } else if $side == "left" {
        ^xrandr --output HDMI-2 --auto --left-of eDP-1 
    } else {
        ^print "Side argument should be either \"right\" or \"left\"."
    }
}

# nix utilities. used to develop using nu as the shell.
export def nixDev [] {
    nix develop -c $env.SHELL
}

export def nixDevi [] {
    nix develop --impure -c $env.SHELL
}


export def loc [p: path = .] {
    ls ($p + /**/*) | where type == file | get name | each {|it| open $it | lines | length } | reduce {|a, b| $a + $b}
}

export def mkmod [p:path] {
    cd (mkdir $p | first)
    touch mod.rs
}
