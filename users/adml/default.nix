_: { config, lib, pkgs, ... }: {
  users.users.adml = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
  };
}
