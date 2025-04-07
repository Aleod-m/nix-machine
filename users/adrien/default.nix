{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.adrien = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ["docker" "wheel" "input" "video" "uinput" "networkmanager" "lxd"];
  };
}
