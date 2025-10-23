{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
  ];
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
