{pkgs, ...}: let 
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
  programs.wlogout = let
    bgImageSection = name: ''
      #${name} {
        background-image: image(-gtk-recolor(url('${pkgs.wlogout}/share/wlogout/assets/${name}.svg'), success #${cyan}, warning #${cyan}, error #${cyan}));
      }
    '';
  in {
    enable = true;

    style = ''
      * {
        background: none;
        color: #${white};
      }

      window {
      	background-color: #${bg};
      }

      button {
        margin: 1rem;
        background-color: #474747;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: 8px;
      }

      button:focus, button:active, button:hover {
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        outline-style: none;
      }

      ${pkgs.lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}
