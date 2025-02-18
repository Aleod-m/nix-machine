{lib, ...}: let
  mkbind = mod: key: action: args: "$mod ${mod}, ${key}, ${action}, ${args}";
  exec = mod: key: cmd: mkbind mod key "exec" cmd;
  action = mod: key: action: mkbind mod key action "";
  layout = mod: key: action: mkbind mod key "layoutmsg" action;

  script = mod: key: name: args: (exec mod key "nu $scripts/${name}.nu ${toString args}");
  switchworkspacebinds =
    map (ws: script "" "${toString (lib.trivial.mod ws 10)}" "swk" ws) [1 2 3 4 5 6 7 8 9 10];
  moveworkspacebinds =
    map (ws: script "SHIFT" "${toString (lib.trivial.mod ws 10)}" "mwk" ws) [1 2 3 4 5 6 7 8 9 10];
in {
  wayland.windowManager.hyprland.settings = {
    # Mouse binds.
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind =
      [
        (script "" "o" "sscr" "")
        (script "Shift" "O" "mscr" "")

        (action "" "mouse:274" "killactive")
        # Programs
        (exec "" "return" "kitty")
        (exec "" "b" "firefox")
        (exec "" "space" "rofi -show drun")
        (exec "SHIFT" "space" "rofi -show run")

        # window state
        (action "SHIFT" "q" "killactive")
        (action "" "v" "togglefloating")
        (action "" "f" "fullscreen")
        (mkbind "SHIFT" "f" "fullscreen" "1")

        # Layout
        (layout "" "n" "cyclenext")
        (layout "" "p" "cycleprev")
        (layout "" "m" "focusmaster")

        (layout "SHIFT" "n" "swapnext")
        (layout "SHIFT" "p" "swapprev")
        (layout "SHIFT" "m" "swapwithmaster")

        # Screen Shot.
        (exec "" "Print" "grimblast --notify --cursor copysave area")
        (exec "CTRL" "Print" "grimblast --notify --cursor copysave active")
        (exec "ALT" "Print" "grimblast --notify --cursor copysave output")
        (exec "SHIFT" "Print" "grimblast --notify --cursor copysave screen")

        # Locking and logout.
        (exec "" "L" "hyprlock")
        (exec "SHIFT ALT" "Q" "wlogout -s -p layer-shell")
        (script "ALT" "left" "decwk" "")
        (script "ALT" "right" "incwk" "")
      ]
      ++ switchworkspacebinds
      ++ moveworkspacebinds;
  };
}
