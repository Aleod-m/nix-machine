{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.home.shells;
  l = lib;
  t = lib.types;
  shellType = t.enum ["bash" "nushell" "zsh" "fish"];
in {
  options = {
    home.shells = {
      default = l.mkOption {
        type = shellType;
        default = "bash";
      };
      enabled = l.mkOption {
        type = t.listOf shellType;
        default = [cfg.home.shells.default];
      };
    };
  };

  config = let
    bashEnabled = __elem "bash" cfg.enabled;
    zshEnabled = __elem "zsh" cfg.enabled;
    nushellEnabled = __elem "nushell" cfg.enabled;
    fishEnabled = __elem "fish" cfg.enabled;
    integrations = {
      enableBashIntegration = bashEnabled;
      enableFishIntegration = fishEnabled;
      enableZshIntegration = zshEnabled;
      enableNushellIntegration = nushellEnabled;
    };
  in {
    programs = {
      bash.enable = bashEnabled;
      zsh.enable = zshEnabled;
      nushell.enable = nushellEnabled;
      fish.enable = fishEnabled;
      # Shell integrations.
      zoxide = integrations;
      starship = integrations;
      direnv = integrations;
    };
  };
}
