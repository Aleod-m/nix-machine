{pkgs, ...}: {
  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = false;
    daemon.settings = {
      "ip-forward" = true;
    };
  };
  virtualisation.incus = {
    enable = true;
    package = pkgs.incus;
    preseed = {
      networks = [
        {
          config = {
            "ipv4.address" = "10.0.100.1/24";
            "ipv4.nat" = "true";
            "ipv4.firewall" = "false";
          };
          name = "incusbr0";
          type = "bridge";
        }
      ];
      profiles = [
        {
          devices = {
            eth0 = {
              name = "eth0";
              network = "incusbr0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              size = "35GiB";
              type = "disk";
            };
          };
          name = "default";
        }
      ];
      storage_pools = [
        {
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
          driver = "dir";
          name = "default";
        }
      ];
    };
  };
  networking.firewall = {
    trustedInterfaces = ["incusbr0"];
    interfaces.incusbr0 = {
      allowedTCPPorts = [53 67];
      allowedUDPPorts = [53 67];
    };
  };
}
