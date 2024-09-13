# If connecting on tty 1 launch Hyprland.
let tty = (tty);

print $tty;

if $tty == "/dev/tty1" {
    exec Hyprland
}
