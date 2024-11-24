# NixOs pc hardware config
{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel" "i2c-dev"];
  boot.extraModulePackages = [];
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
  swapDevices = [{device = "/dev/disk/by-label/swap";}];

  hardware.nvidia.prime = {
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  hardware.enableRedistributableFirmware = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };

  networking.interfaces = {
    enp4s0.useDHCP = false;
    wlp3s0.useDHCP = false;
  };
}
