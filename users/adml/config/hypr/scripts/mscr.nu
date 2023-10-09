
use hypr.nu *

def main [] {
    let target_ws = (monitors 
        | where id != (active_window | get monitor)
        | first
        | get workspaces
        | where active
        | get id
        | first);

    move_active_window $target_ws
}

