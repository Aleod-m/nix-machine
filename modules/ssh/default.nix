{ config, lib, pkgs, modulesPath, ... }: {
  services = {
    openssh.enable  = true;
  };
  programs.gnupg.agent = {
    enable           = true;
    enableSSHSupport = true;
  };
}
