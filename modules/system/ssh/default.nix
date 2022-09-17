_: { config, lib, pkgs, ... }: with lib; {

  options = {
    services.ssh.enable = mkEnableOption "ssh"; 
  };

  config = mkIf config.services.ssh.enable {
    services = {
      openssh.enable  = true;
    };
    programs.gnupg.agent = {
      enable           = true;
      enableSSHSupport = true;
    };
  };
}
