{
  pkgs,
  lib,
  config,
  ...
}: {
  # Imports the hardware configuration
  imports = [./hardware.nix ./bibvpn.nix];
  environment.systemPackages = with pkgs; [ecryptfs];
  fonts.packages = with pkgs.nerd-fonts; [zed-mono jetbrains-mono];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  system.stateVersion = "24.05";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.systemd.enable = true;
}
