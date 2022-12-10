_: {
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.rustUtils;
in {
  options = {
    programs.rustUtils = {
      enableDefaultAliases = mkOption {
        type = types.bool;
        default = true;
      };

      exaAsLs = mkOption {
        type = types.bool;
        default = true;
      };

      zoxideAsCd = mkOption {
        type = types.bool;
        default = true;
      };

      starship.settings = {
        add_newline = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };
  };

  config = {
    home = {
      packages = with pkgs; [
        bat
        exa
        zoxide
        ripgrep
        starship
      ];
    };
  };
}
