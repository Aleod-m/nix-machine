# Workspace scripts

These scripts mimick the way gnome manages workspaces across screens. They support 10 workspaces. These workspaces are 1-indexed and `0` is considered the tenth workspace.

When using a multi monitor setup it maps the workspace true id 
(the ones defined by hyprland) from `0` to `9` to the monitor with id `0`, the workspaces from `10` to `19` to the monitor with id `1` ect.

- `assign.sh` set the workspace rules so that workspaces are associated with the right screen. Run if it goes out of sync like when (un)pluging a monitor.
- `dec.sh` move to the previous workspace wraping.
- `inc.sh` move to the next workspace wraping.
- `move.sh` move the active window to the workspace silently.
- `switch.sh` switch all screens to the workspace silently.
