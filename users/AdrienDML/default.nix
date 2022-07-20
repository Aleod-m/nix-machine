{ config, lib, pkgs, ... }: {
  users.users.AdrienDML = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
  };
}
