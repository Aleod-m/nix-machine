use hypr.nu *

def main [] {
    monitors 
        | where id != (active_window | get monitor)
        | first
        | get workspaces
        | where active
        | get name
        | first
        | switch_ws
}