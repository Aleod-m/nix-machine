{}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  
    enableNvidiaPatches = true;
  };
  services = {
    xserver.enable = true;
    xserver.displayManager.lightdm.enable = true;
  };
  # use Wayland where possible (electron)
  environment.variables.NIXOS_OZONE_WL = "1";

}
