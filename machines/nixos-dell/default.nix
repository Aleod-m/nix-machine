{
  pkgs,
  lib,
  mlib,
  config,
  ...
}: mlib.enable.services [ "flatpak" ] {
  nixpkgs.config.allowUnfree = true;
  # Imports the hardware configuration
  imports = [./hardware.nix ./bibvpn.nix];
  fonts.packages = with pkgs.nerd-fonts; [zed-mono jetbrains-mono];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  system.stateVersion = "24.05";

  # Bootloader.
  boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		initrd.systemd.enable = true;
		enableContainers = true; 
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

  services = { 
		fwupd.enable = true;
  	printing.enable = true;
  	avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
	};
}
