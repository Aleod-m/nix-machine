{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.adrien = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
  };
}
