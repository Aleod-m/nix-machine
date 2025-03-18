export def main [] {
    l
}

export def l [-v] {
    git worktree list 
        | lines 
        | skip 1
        | each {
            tr -s " " " "
                | parse "{path} {commit} [{branch}]" 
                | first 
        }
}

def branches [] {
    git branch --format "%(refname:lstrip=-1)" 
}

export def clone [url:string, path: path] {
    git clone --bare url path
}

export def root [] {
    let worktree_root: path = try {
        git rev-parse --show-prefix 
            | str trim 
            | do { if ($in | is-empty) {pwd} else {$in}}
    } catch {
        return (pwd);
    };

    let gitdir = ($worktree_root | path join ".git");
    if ((gitdir | path type) == dir) {
        return $worktree_root
    } else {
        open $gitdir | from yaml | get gitdir

    }
}

export def --env a [branch:string@branches] {
    cd (root);
    git worktree add $branch;
    cd $branch;
}

export def --env s [worktree: string@branches] {
    cd (root);
    if ($worktree | path exists) {
        cd $worktree
    } else {
        a $worktree
    }
}
