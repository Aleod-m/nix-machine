{...}: {
  networking = {
    firewall = {
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

    resolvconf.dnsExtensionMechanism = false;
    dhcpcd.enable = false;
    networkmanager.enable = true;
  };
  programs.nm-applet.enable = true;
}
