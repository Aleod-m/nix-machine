{
  pkgs,
  lib,
  ...
}: {
  # Imports the hardware configuration
  imports = [./hardware.nix];
  environment.systemPackages = with pkgs; [ecryptfs];
  fonts.packages = with pkgs; [nerdfonts];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  services.printing.enable = true;
  system.stateVersion = "24.05";
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.systemd.enable = true;
}
