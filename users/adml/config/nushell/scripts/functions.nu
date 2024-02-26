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
    ls ($p + /**/*) 
        | where type == file 
        | filter { $in | get name | str ends-with $ext }
        | get name 
        | each { open $in | lines | length }
        | reduce {|a, b| $a + $b}
}

export def timer [task, time: duration = 1sec, --loop = true] {
    do $task;
    sleep $time;
    while $loop {
        do $task;
        sleep $time;
    }
}
