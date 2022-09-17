# NixOs pc hardware config
{ config, lib, pkgs, modulesPath, ... }: {

  system.stateVersion = "21.11";
  time.timeZone       = "Europe/Paris";
  i18n.defaultLocale  = "en_US.UTF-8";

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
      hostName                         = "nixos-pc";
      networkmanager.enable            = true;
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

  services = {
      printing.enable = true;
      picom = {
          enable = true;
      };
      xserver = {
          enable                        = true;
          videoDrivers                  = [ "nvidia" ];
          libinput.enable               = true;
          displayManager.lightdm.enable = true;
          layout                        = "fr";
          windowManager.awesome = {
              enable     = true;
              luaModules = with pkgs.luaPackages; [
                  luarocks
                      luadbi-mysql
              ];
          };
     };
  };

  environment.systemPackages = with pkgs; [
    firefox
    xfce.thunar
    curl
    nano
    kitty
    git
  ];

  programs.mtr.enable  = true;
}
