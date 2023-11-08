{
  config,
  pkgs,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  nix.allowedUnfree = ["nvidia-x11"];
  hardware = {
    opengl = {
      enable =
        true;
      driSupport32Bit =
        true;
    };
    nvidia = {prime = {
      sync.enable =
        true;
    };};
  };
  services.xserver.videoDrivers = ["nvidia"];
  environment.sessionVariables =
    {__GLX_VENDOR_LIBRARY_NAME = "nvidia";}
    #; boot.kernelParams = [ "module_blacklist=i915" ]
    ;
}
