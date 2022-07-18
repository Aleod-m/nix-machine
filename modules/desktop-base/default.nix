{pkgs, config, lib, ...}:
with lib;
{
  options =  {
    wayland.enable = mkEnableOption "Wayland";
    x11.enable = mkEnableOption "X11";
  };

  config = {
    networking = {
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
      openssh.enable  = true;
      blueman.enable  = true;
      pipewire = {
        enable                = true;
        alsa.enable           = true;
        pulse.enable          = true;
        jack.enable           = true;
        alsa.support32Bit     = true;
      };
    };

    programs.mtr.enable  = true;
    programs.gnupg.agent = {
      enable           = true;
      enableSSHSupport = true;
    };

    environment.systemPackages = with pkgs; [
      curl
      nano
      git
    ] ++ mkIf config.wayland [ 
      wl-clipboard
      grim
    ] ++ mkIf config.x11 [ 
      xclip 
      peek
    ];
  };
}
