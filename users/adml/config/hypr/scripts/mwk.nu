use hypr.nu *

# Moves the active window silently to corresponding workspace.
# If you want to automaticaly switch to the workspace remove the true.
# It doesn't switch the other screens tho.
def main [x: int] {
    let win_pid = (active_window | get pid);
    let target_ws = (monitor_by_id (active_window | get monitor) | get workspaces | get name | get $x);
    # construct a list containing for each screen a list of the current workspace and the workspace to go to. 
    print $"($win_pid)" $target_ws;
    move_win_to_ws $win_pid $target_ws true
}