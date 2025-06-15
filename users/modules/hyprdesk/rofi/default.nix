{lib, pkgs, config, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "ghostty";
    font = "JetBrains Mono Nerd Font monospace 10";
    extraConfig = {
      show-icons = true;
    };
    theme = let 
      inherit (config.lib.formats.rasi) mkLiteral;
    in {

      "*" = {
        green = mkLiteral "#97e023";
        orange = mkLiteral "#fa8419";
        yellow = mkLiteral "#dfd561";
        purple = mkLiteral "#9c64fe";
        red = mkLiteral "#f3005f";
        cyan = mkLiteral "#57d1ea";
        blue = mkLiteral "#0e6172";
        grey = mkLiteral "#929276";
        white = mkLiteral "#f6f6ee";
        foreground = mkLiteral "#f6f6ee";
        background = mkLiteral "#191919";
        background-light = mkLiteral "#5e5e5e";
        normal-foreground = mkLiteral "@foreground";
        normal-background = mkLiteral "@background";
        selected-normal-foreground = mkLiteral "@cyan";
        selected-normal-background = mkLiteral "@background-light";
        alternate-normal-background = mkLiteral "rgba ( 45, 48, 59, 1 % )";
        selected-urgent-foreground = mkLiteral "rgba ( 249, 249, 249, 100 % )";
        urgent-foreground = mkLiteral "rgba ( 204, 102, 102, 100 % )";
        alternate-urgent-background = mkLiteral "rgba ( 75, 81, 96, 90 % )";
        active-foreground = mkLiteral "rgba ( 101, 172, 255, 100 % )";
        lightbg = mkLiteral "rgba ( 238, 232, 213, 100 % )";
        selected-active-foreground = mkLiteral "rgba ( 249, 249, 249, 100 % )";
        alternate-active-background = mkLiteral "rgba ( 45, 48, 59, 88 % )";
        alternate-normal-foreground = mkLiteral "@foreground";
        lightfg = mkLiteral "rgba ( 88, 104, 117, 100 % )";
        border-color = mkLiteral "rgba ( 124, 131, 137, 100 % )";
        spacing = mkLiteral "2";
        separatorcolor = mkLiteral "rgba ( 45, 48, 59, 1 % )";
        urgent-background = mkLiteral "rgba ( 45, 48, 59, 15 % )";
        selected-urgent-background = mkLiteral "rgba ( 165, 66, 66, 100 % )";
        alternate-urgent-foreground = mkLiteral "@urgent-foreground";
        background-color = mkLiteral "rgba ( 0, 0, 0, 0 % )";
        alternate-active-foreground = mkLiteral "@active-foreground";
        active-background = mkLiteral "rgba ( 29, 31, 33, 17 % )";
        selected-active-background = mkLiteral "rgba ( 26, 28, 35, 100 % )";
      };

      window = {
        background-color = mkLiteral "@background";
        border = mkLiteral "1";
        border-color = mkLiteral "@cyan";
        border-radius = mkLiteral "3";
        padding = mkLiteral "30";
      };

      listview = {
        lines = mkLiteral "10";
        columns = mkLiteral "3";
      };

      mainbox = {
        border = mkLiteral "0";
        padding = mkLiteral "0";
      };

      message = {
        border = mkLiteral "2px 0px 0px ";
        border-color = mkLiteral "@separatorcolor";
        padding = mkLiteral "1px ";
      };

      textbox = {
        text-color = mkLiteral "@foreground";
      };

      listview = {
        fixed-height = mkLiteral "0";
        border = mkLiteral "8px 0px 0px ";
        border-color = mkLiteral "@separatorcolor";
        spacing = mkLiteral "8px ";
        scrollbar = mkLiteral "false";
        padding = mkLiteral "2px 0px 0px ";
      };

      element = {
        border = mkLiteral "0";
        padding = mkLiteral "1px ";
      };
      element-text = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element.normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-foreground";
      };
      "element.normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };
      "element.normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };
      "element.selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };
      "element.selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@selected-urgent-foreground";
      };
      "element.selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-foreground";
      };
      "element.alternate.normal" = {
        background-color = mkLiteral "@alternate-normal-background";
        text-color = mkLiteral "@alternate-normal-foreground";
      };
      "element.alternate.urgent" = {
        background-color = mkLiteral "@alternate-urgent-background";
        text-color = mkLiteral "@alternate-urgent-foreground";
      };
      "element.alternate.active" = {
        background-color = mkLiteral "@alternate-active-background";
        text-color = mkLiteral "@alternate-active-foreground";
      };
      scrollbar = {
        width = mkLiteral "4px";
        border = mkLiteral "0";
        handle-color = mkLiteral "@normal-foreground";
        handle-width = mkLiteral "8px";
        padding = mkLiteral "0";
      };

      mode-switcher = {
        border = mkLiteral "2px 0px 0px";
        border-color = mkLiteral "@separatorcolor";
      };

      button = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
      };

      "button.selected" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };

      inputbar = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
        padding = mkLiteral "1px";
      };
      case-indicator = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
      };
      entry = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
      };
      prompt = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
      };
      inputbar = {
        children = mkLiteral "[ prompt,textbox-prompt-colon,entry,case-indicator ]";
      };
      textbox-prompt-colon = {
        expand = mkLiteral "false";
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@normal-foreground";
      };
    };
  }; 
}
