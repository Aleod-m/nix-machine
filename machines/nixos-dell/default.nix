{
  pkgs,
  lib,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  # Imports the hardware configuration
  imports = [./hardware.nix ./bibvpn.nix];
  environment.systemPackages = with pkgs; [ecryptfs];
  fonts.packages = with pkgs.nerd-fonts; [zed-mono jetbrains-mono];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  system.stateVersion = "24.05";

  # Bootloader.
	boot.enableContainers = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fwupd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.systemd.enable = true;
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
