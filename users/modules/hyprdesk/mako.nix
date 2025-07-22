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
    settings = {
      anchor = "top-center";
      group-by = "app-name";
      default-timeout = 3000;
      ignore-timeout = true;
      max-visible = 3;

      height = 40;
      width = 400;
      background-color = "#${bg}";

      format = "<b>%s</b> : %b";
      markup = true;
      text-color = "#${white}";

      icons = true;
      max-icon-size = 40;

      border-color = "#${green}";
      border-radius = 5;
      border-size = 1;
    };

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
