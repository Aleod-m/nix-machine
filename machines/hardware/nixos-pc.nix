# NixOs pc hardware config
_:
{ config, lib, pkgs, ... }: {
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/media/Drive2" = {
    device = "/dev/disk/by-uuid/b614af56-193e-4174-9ec8-3e6e73d886f8";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fonts.fonts = with pkgs; [
      nerdfonts
  ];
  boot.loader = {
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;
  };

  networking = {
      resolvconf.dnsExtensionMechanism = false;
      firewall.enable                  = false;
      interfaces = {
          enp4s0.useDHCP = true;
          wlp3s0.useDHCP = true;
      };
  };  

  console = {
      font   = "Lat2-Terminus16";
      keyMap = "fr";
  };
}
