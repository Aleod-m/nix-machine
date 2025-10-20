{lib, ...}: let
  mkbind = mod: key: action: args: "$mod ${mod}, ${key}, ${action}, ${args}";
  exec = mod: key: cmd: mkbind mod key "exec" cmd;
  action = mod: key: action: mkbind mod key action "";
  layout = mod: key: action: mkbind mod key "layoutmsg" action;

  script = mod: key: name: args: (exec mod key "$scripts/${name}.sh ${toString args}");
  workspaces = __genList (x: x + 1) 10;
  switchworkspacebinds =
    map (ws: script "" "${toString (lib.trivial.mod ws 10)}" "swk" ws) workspaces;
  moveworkspacebinds =
    map (ws: script "SHIFT" "${toString (lib.trivial.mod ws 10)}" "mwk" ws) workspaces;
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    # Mouse binds.
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    gesture = [
      "3, right, dispatcher, exec, $scripts/decwk.sh"
      "3, left, dispatcher, exec, $scripts/incwk.sh"
    ];

    bind =
      [
        # Switch screen / Move window to other screen.
        (script "" "o" "sscr" "")
        (script "Shift" "O" "mscr" "")

        (action "" "mouse:274" "killactive")
        # Programs
        (exec "" "return" "ghostty")
        (exec "" "b" "rofi -show qute-sesh")
        (exec "" "a" "rofi -show hypr-action")
        (exec "" "w" "rofi -show window")
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
        (exec "" "Print" "grimblast --notify copysave area")
        (exec "CTRL" "Print" "grimblast --notify --cursor copysave active")
        (exec "ALT" "Print" "grimblast --notify --cursor copysave output")
        (exec "SHIFT" "Print" "grimblast --notify --cursor copysave screen")

        # Locking and logout.
        (exec "" "L" "hyprlock")
        (exec "SHIFT ALT" "Q" "wlogout -s -p layer-shell")

        # Workspace increment / decrement.
        (script "ALT" "left" "decwk" "")
        (script "ALT" "right" "incwk" "")
        (script "" "mouse_up" "incwk" "")
        (script "" "mouse_up" "decwk" "")
      ]
      ++ switchworkspacebinds
      ++ moveworkspacebinds;
  };
}
