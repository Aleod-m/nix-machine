inputs: 
{ config, lib, pkgs, ... }: 
{
  users.users.adml = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
  };
}
