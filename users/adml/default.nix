{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.adml = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = ["docker" "wheel" "input" "video" "uinput" "networkmanager"];
  };
  environment.shells = [pkgs.nushell];
}
