{...}: {
  networking = {
    # Per interface useDHCP are to be disabled in the hardware.nix file.
    useDHCP = false;

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

    networkmanager = {
      enable = true;
    };
  };
}
