{lib, config, ...}: let
  cfg = config.programs.ssh.remoterc; 
  l = lib;
  t = lib.types;
in {
  options = {
    programs.ssh.remoterc = {
      enable = l.mkEnableOption "remote bashrc";
      text = l.mkOption {
        type = t.str;
        default = null;
      };
    };
  };

  config = l.mkIf cfg.enable {
    programs.ssh.extraConfig = ''
    Host * !git*
      ## Remote rc from nix config. ##
      PermitLocalCommand yes
      LocalCommand scp ~/.remoterc %r@%n:/tmp/.remoterc
      RemoteCommand bash --rcfile "/tmp/.remoterc"
      ## END ##
    '';
    home.file.remoterc = {
      enable = true;
      target = ".remoterc";
      text = cfg.text;
    };
  };
}
