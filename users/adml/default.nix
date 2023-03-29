inputs: {
  config,
  lib,
  pkgs,
  ...
}: {
  users.extraUsers.adml = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ["wheel" "input" "video" "uinput" "networkmanager"];
  };
}
