{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.support32Bit = true;
    };
    pulseaudio.enable = false;
  };
}
