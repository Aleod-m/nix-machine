{self, ...}@ inputs: 
{lib, config, ...}: 
let
  l = lib;
  t = lib.types;
  cfg = config.de.hyprland;
in {

  imports = [
    inputs.hyprland.nixosModules.default
  ];

  options.de.hyprland = {
    enable = l.mkEnableOption "Hyperland window manager.";
  };

  config = l.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
      nvidiaPatches = true;
    };
  };
}