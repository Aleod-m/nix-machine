# Add your workspaces here. 
# id is your monitor id. 
# for me 0 is my laptop screen and 1 my second screen. 
# TODO: generate this automatically.  
def monitor_workspaces [id: int] {
    let start = 1 + $id * 10;
    $start..($start + 9)
}


export def workspaces [] {
    hyprctl workspaces -j | from json;
}

export def wokspace_by_name [name: string] {
    workspaces | where name == name 
}

export def monitors [] {
    let mon = (hyprctl monitors -j | from json);
    let ws =  ($mon 
        | get id 
        | each {|id|
            let m_ws = (monitor_workspaces $id);
            let a_ws_names = ($mon 
                | get activeWorkspace 
                | get $id 
                | get id
            );
            $m_ws 
            | wrap id 
            | merge ($m_ws 
                | each {|name| $name == $a_ws_names } 
                | wrap active
            ) 
        }
        | wrap workspaces
        );
    $mon 
        | reject activeWorkspace 
        | merge $ws
}

export def monitor_by_id [id: int] {
    (monitors | where id == $id) | first
}

export def active_window [] {
    hyprctl activewindow -j | from json
}

export def move_active_window [
    ws_id: int
    silent: bool = false
    ] {
    let win = (hypr_pref address (active_window | get address));
    if $silent {
        hyprctl dispatch -- movetoworkspacesilent $ws_id
    } else {
        hyprctl dispatch -- movetoworkspace $ws_id
    }
}

def hypr_pref [decorator:string, name:string] {
    ([$decorator, ":", $name] | str join)
}

export def focus_scr [id: int] {
    hyprctl dispatch -- focusmonitor $id
}

export def switch_ws [$ws_id] {
    hyprctl dispatch -- workspace $ws_id
}


def parse_event [line: string] {
    let e = ($line | parse "{name}>>{data}");
    if $e.name == "workspace" {
        {
            type: WorkspaceChanged,
            data: { name: $e.data }
        }
    } else if $e.name == "focusedmon" {
        {
            type: WorkspaceChanged,
            data: ($e.data | parse "{mon_name},{ws_name}"),
        }
    } else if $e.name == activewindow {
        print "itworks";
        {
            type: WindowFocused,
            data: ($e.data | parse "{class},{title}"),
        }
    } else if $e.name == "fullscreen" {
        {
            type: WindowToggledFullscreen,
            data: { fullscreen: ($e.data | into bool) },
        }
    } else if $e.name == "monitorremoved" {
        {
            type: MonitorRemoved,
            data: { name: $e.data },
        }
    } else if $e.name == "monitoradded" {
        {
            type: MonitorAdded,
            data: { name: $e.data },
        }
    } else if $e.name == "createworkspace" {
        {
            type: WorkspaceCreated,
            data: { name: $e.data },
        }
    } else if $e.name == "destroyworkspace" {
        {
            type: WorkspaceDestroyed,
            data: { name: $e.data },
        }
    } else if $e.name == "moveworkspace" {
        {
            type: WorkspaceDestroyed,
            data: ($e.data | parse "{ws_name},{mon_name}"),
        }
    } else if $e.name == "activelayout" {
        {
            type: LayoutChanged,
            data: ($e.data | parse "{kbd_name},{layout_name}"),
        }
    } else if $e.name == "openwindow" {
        {
            type: WindowOpened,
            data: ($e.data | parse "{address},{ws_name},{class},{title}"),
        }
    } else if $e.name == "closewindow" {
        {
            type: WindowClosed,
            data: { address: $e.data },
        }
    } else if $e.name == "movewindow" {
        {
            type: WindowMoved,
            data: ($e.data | parse "{address},{ws_name}"),
        }
    } else if $e.name == "openlayer" {
        {
            type: LayerOpened,
            data: {namespame: $e.data},
        }
    } else if $e.name == "closelayer" {
        {
            type: LayerClosed,
            data: {namespame: $e.data},
        }
    } else if $e.name == "submap" {
        {
            type: Submap,
            data: {name: $e.data},
        }
    } else if $e.name == "changefloatingmode" {
        {
            type: WindowToggleFloating,
            data: ($e.data | parse "{address},{state}"),
        }
    } else if $e.name == "urgent" {
        {
            type: WindowUrgent,
            data: { address: $e.data },
        }
    } else if $e.name == "minimize" {
        {
            type: WindowMinimized,
            data: ($e.data | parse "{address},{state}"),
        }
    } else {
        print "notworky";
        $e
    };
}

export def read_socket [] {
    let hypr_socket = ([\
        /tmp/hypr
        $env.HYPRLAND_INSTANCE_SIGNATURE 
        .socket2.sock 
        ] | path join);
    notify-send "opening";
    socat - $"UNIX-CONNECT:($hypr_socket)"
}
