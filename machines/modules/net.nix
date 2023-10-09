{
  networking = {
    firewall = {
      trustedInterfaces = ["tailscale0"];
      checkReversePath = "loose";
      enable = true;
      allowedTCPPorts = [80 443];
      allowedTCPPortRanges = [
        {
          from = 8000;
          to = 9000;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };

    networkmanager = {
        enable = true;
        dns = "systemd-resolve";
        wifi.powersave = true;
    };
  };
}
