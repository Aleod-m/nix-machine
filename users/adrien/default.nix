{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.adrien = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };
}
