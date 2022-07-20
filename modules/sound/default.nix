{ config, lib, pkgs, ... }: {
  sound.enable = true;
  services = {
    pipewire = {
      enable                = true;
      alsa.enable           = true;
      pulse.enable          = true;
      jack.enable           = true;
      alsa.support32Bit     = true;
    };
  };
}
