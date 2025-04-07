# If connecting on tty 1 launch Hyprland.
let tty = (tty);
if $tty == "/dev/tty1" {
    exec Hyprland
}

bash -c "env -i PATH=\"$PATH\" HOME=\"$HOME\" bash -c 'source ~/.profile && env'" 
     | parse "{name}={val}" 
     | update val { split row ':' }
     | reject PATH PWD _
     | transpose -r -d
