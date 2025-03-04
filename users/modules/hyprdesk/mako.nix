{...}: let 
  bg = "191919";
  green  = "97e023";
  orange = "fa8419";
  yellow = "dfd561";
  purple = "9c64fe";
  red    = "f3005f";
  cyan   = "57d1ea";
  blue   = "0e6172";
  grey   = "929276";
  white  = "f6f6ee";
in {
  services.mako = {
    enable = true;
    anchor = "top-center";
    groupBy = "app-name";
    defaultTimeout = 2000;
    maxVisible = 3;

    height = 40;
    width = 400;
    backgroundColor = "#${bg}";

    format = "<b>%s</b> : %b";
    markup = true;
    textColor = "#${white}";

    icons = true;
    maxIconSize = 40;

    borderColor = "#${green}";
    borderRadius = 5;
    borderSize = 1;

    extraConfig = ''
      [urgency=low]
      border-color=#${green}

      [urgency=normal]
      border-color=#${orange}

      [urgency=high]
      border-color=#${red}
      default-timeout=0

      [mode=dnd]
      invisible=true
    '';
  };
}
