{
  config,
  pkgs,
  ...
}: {
  nix.allowedUnfree = ["nvidia-x11"];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      prime = {
        sync.enable = true;
      };
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  environment.sessionVariables = {__GLX_VENDOR_LIBRARY_NAME = "nvidia";};
}
