{lib, ...}: {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.support32Bit = true;
      };
    };

    hardware.pulseaudio.enable = lib.mkForce false;
    environment.systemPackages = with pkgs; [
      pamixer
      playerctl
      pulseaudio
    ];
}
