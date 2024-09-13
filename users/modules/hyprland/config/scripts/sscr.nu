use hypr.nu *

def main [] {
    focus_scr (monitors 
        | where not focused
        | get id
        | first)
}