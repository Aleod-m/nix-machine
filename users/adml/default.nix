{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.adml = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ["docker" "wheel" "input" "video" "uinput" "networkmanager"];
  };
  environment.shells = [pkgs.nushell];
}
