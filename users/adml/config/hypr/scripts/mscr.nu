
use hypr.nu *

def main [] {
    let target_ws = (monitors 
        | where id != (active_window | get monitor)
        | first
        | get workspaces
        | where active
        | get name
        | first);

    move_win_to_ws (active_window | get pid) $target_ws
}