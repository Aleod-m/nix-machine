use hypr.nu *

def permute [] {
    let d = $in;
    let f = ($d | first);
    $d | skip 1 | append $f
}

def add_column [name: string, col: list] {
    $in | merge ($col | each {|| {$name: $in}})
}

def main [] {
    let forcused_scr = (monitors | where focused | first | get id);

    let monitors_id = (monitors | get id);

    let target_ws = (
        monitors 
        | get workspaces 
        | each { |w_m|
            let p_ws  = (
                $w_m 
                | get id
                | permute
            );
            $w_m 
                | reject id 
                | add_column id $p_ws 
                | where active 
                | get id
        }
    );
    
    $monitors_id | zip $target_ws | each {|scr_ws|
        focus_scr ($scr_ws | get 0);
        switch_ws ($scr_ws | get 1); 
    };
    # Restore the screen focus.
    focus_scr $forcused_scr;
}
