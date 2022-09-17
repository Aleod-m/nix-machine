inputs: { config, lib, pkgs, ... }: with lib;
let
  cfg = config.de.hyprland;
in {
  imports = [ 
    inputs.hyprland.nixosModules.default
  ];

  options = {
      de.hyprland.enable = mkEnableOption "awesome";
  };

  config = mkIf cfg.enable {
    de.displayProtocol = "wayland";
    programs.hyprland.enable = true;
  };
}
