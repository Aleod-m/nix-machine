
def permute [--reverse(-r)]: list -> list {
    if ($reverse) {
        let f = ($in | last);
        return [$f] | append ($in | drop 1);
    } else {
        let f = ($in | first);
        return $in | skip 1 | append $f;
    }
}

def update_col [name: cell-path, update_fn: closure]: table -> table {
    let old_val = $in | get $name;
    $in | reject $name | insert $name ($old_val | update_fn)
}
