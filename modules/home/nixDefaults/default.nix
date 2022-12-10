_: {
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.nix;
in {
  options = {
    nix.allowedUnfree = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [];
      description = ''
        Allows for  unfree packages by their name.
      '';
    };
  };
  config = {
    nixpkgs.config.allowUnfreePredicate =
      if (cfg.allowedUnfree == [])
      then (_: false)
      else (pkg: builtins.elem (lib.getName pkg) cfg.allowedUnfree);
  };
}
