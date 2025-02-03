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
    format = "<b>%s</b> : %b";
    groupBy = "app-name";

    height = 40;
    width = 400;

    icons = true;
    maxIconSize = 40;

    borderColor = "#${green}";
    backgroundColor = "#${bg}";
    textColor = "#${white}";
    borderSize = 1;
  };
}
