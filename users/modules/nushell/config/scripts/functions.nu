# Various directories helpers.
export def --env up [nb: int = 1] {
    let path = ( 1..($nb) | each { |_| ".." } | reduce { |it, acc| $acc + "/" + $it } )
    cd $path 
}

export def --env mkcd [name: path] {
    mkdir $name; cd $name; $name
}

# nix utilities. used to develop using nu as the shell.
export def loc [ext: string, p: path = .] {
    glob $"($p)/**/*.($ext)"
        | each {|it| print $it; open $it | lines | filter {is-not-empty} | length }
        | do {print $in; $in}
        | reduce --fold 0 {|a, b| $a + $b}
}

export def timer [task, time: duration = 1sec, --loop = true] {
    do $task;
    while $loop {
        sleep $time;
        do $task;
    }
}

export def rr [
    task: closure,
    --clear(-c) = true,
] {
    mut exit = false;
    while not $exit {
        clear;
        try { do $task } catch {};

        $exit =  (input "\nexit? (y/n)") == "y";
    }
}

export def psf [names] {
    $in | where {|$proc| not ($names | reduce --fold false {|name, acc| $acc or $name =~ $proc.name}) } 
}
