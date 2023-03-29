

# Add your workspaces here. 
# id is your monitor id. 
# for me 0 is my laptop screen and 1 my second screen. 
# TODO: generate this automatically.  
def monitor_workspaces [id: int] {
    if $id == 0 {
        [
            m0,
            m1,
            m2,
            m3,
            m4,
            m5,
            m6,
            m7,
            m8,
            m9,
        ]
    } else if $id == 1 {
        [
            s0,
            s1,
            s2,
            s3,
            s4,
            s5,
            s6,
            s7,
            s8,
            s9,
        ]
    }
}


export def workspaces [] {
    hyprctl workspaces -j | from json;
}

export def wokspace_by_name [name: string] {
    workspaces | where name == name 
}

export def monitors [] {
    let mon = (hyprctl monitors -j | from json);
    let ws =  ($mon | get id | each {|id|
        let m_ws = (monitor_workspaces $id);
        let a_ws_names = ($mon | get activeWorkspace | get $id | get name);
        $m_ws | wrap name | merge ($m_ws | each {|name| $name == $a_ws_names } | wrap active) 
    } | wrap workspaces);
    $mon | reject activeWorkspace | merge $ws
}

export def monitor_by_id [id: int] {
    (monitors | where id == $id) | first
}

export def active_window [] {
    hyprctl activewindow -j | from json
}

export def move_active_window [] {
    let wpid = (hypr_pref pid (active_window | get pid));
    hyprctl dispatch -- movetoworkspace $wpid
}

export def move_win_to_ws [
    win_pid: int
    ws_name: string
    silent = false
    ] {
    let arg = ([(hypr_pref name $ws_name), ",", (hypr_pref pid $"($win_pid)")] | str join);
    print $arg;
    if $silent {
        hyprctl dispatch -- movetoworkspacesilent $arg
    } else {
        hyprctl dispatch -- movetoworkspace $arg
    }
}

def hypr_pref [decorator:string,name: string] {
    ([$decorator, ":", $name] | str join)
}

export def switch_ws [] {
    each {|n| hyprctl dispatch -- workspace (hypr_pref name $n) }
}