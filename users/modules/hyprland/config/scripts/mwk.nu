use hypr.nu *

# Moves the active window silently to corresponding workspace.
# If you want to automaticaly switch to the workspace remove the true.
# It doesn't switch the other screens tho.
def main [ws_id: int] {
    let ws_ind = $ws_id - 1;
    
    let win_title = (active_window | get title);
    let target_ws = (monitor_by_id (active_window | get monitor) | get workspaces | get id | get $ws_ind);
    # construct a list containing for each screen a list of the current workspace and the workspace to go to. 
    move_active_window $target_ws true
}
