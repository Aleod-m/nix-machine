_: { config, lib, ... }: with lib;
let 
nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec -a "$0" "$@"
'';
in {
  options = {
    driver.nvidia.enable = mkEnableOption "Nvidia Drivers";
  };

  config = mkIf config.driver.nvidia.enable {
    hardware = {
      opengl.enable = true;
      nvidia.prime = {
          offload.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
      };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = [
      nvidia-offload 
    ];
  };
}
