{ pkgs, config, ... }:
{
  users.users.AdrienDML = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
    shell = pkgs.nushell;
  };
}
