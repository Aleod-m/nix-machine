{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.nix;
  l = lib;
  t = lib.types;
  boolToString = b:
    if b
    then "true"
    else "false";
in {
  options = {
    nix = {
      allowedUnfree = l.mkOption {
        type = t.listOf t.str;
        default = [];
      };
      flakes.enable = l.mkOption {
        type = t.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
      # TODO: implement config
      flakes.keep-outputs = l.mkOption {
        type = t.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
      # TODO: implement config
      flakes.keep-derivations = l.mkOption {
        type = t.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
      gc.enable = l.mkEnableOption {
        type = t.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.flakes.enable {
      nix.extraOptions = let
        keep-outputs = boolToString cfg.flakes.keep-outputs;
        keep-derivations = boolToString cfg.flakes.keep-derivations;
      in ''
        experimental-features = nix-command flakes
        keep-outputs = ${keep-outputs}
        keep-derivations = ${keep-derivations}
      '';
    })
    (lib.mkIf cfg.gc.enable {
      nix.autoOptimiseStore = true;
      nix.settings.auto-optimise-store = lib.mkDefault true;
      nix.gc.automatic = lib.mkDefault true;
      nix.gc.options = lib.mkDefault "--delete-older-than 10d";
    })
    (lib.mkIf (cfg.allowedUnfree != []) {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = pkgs: __elem (lib.getName pkgs) config.allowedUnfree;
    })
  ];
}
