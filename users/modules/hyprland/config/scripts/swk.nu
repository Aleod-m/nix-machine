use hypr.nu *

# Send all screen to the nth workspace defined.
def main [ws_id: int] {
    let ws_ind = $ws_id - 1;
    
    let forcused_scr = (monitors | where focused | first | get id);
    # Get the source workspace for each screen.
    let source_ws = (monitors | get id);
    let target_ws = (monitors | get workspaces | each {|w|  $w | get id | get $ws_ind});
    
    # construct a list containing for each screen a list of the current workspace and the workspace to go to. 
    $source_ws | zip $target_ws | each {|scr_ws|
        focus_scr ($scr_ws | get 0);
        switch_ws ($scr_ws | get 1); 
    };
    # Restore the screen focus.
    focus_scr $forcused_scr;
}