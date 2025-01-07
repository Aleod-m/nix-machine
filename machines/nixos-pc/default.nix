{
  pkgs,
  lib,
  self,
  mlib,
  ...
}:
{
  # Imports the hardware configuration
  imports = [./hardware.nix];
  fonts.packages = with pkgs.nerd-fonts; [zed-mono jetbrains-mono];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "21.11";

} // mlib.enable.services [
  "flatpak"
]
