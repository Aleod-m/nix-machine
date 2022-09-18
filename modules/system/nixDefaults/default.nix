_: { pkgs, lib, config, ... }: 
let
  cfg = config.nix;
  types = lib.types;
in {
  options = {
    nix = {
      allowedUnfree = lib.mkOption {
        type = types.listOf types.string;
        default = [];
        description = ''
          Allows for  unfree packages by their name.
        '';
         };
      flakes.enable = lib.mkOption {
        type = types.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
      gc.enable = lib.mkEnableOption {
        type = types.bool;
        default = true;
        description = ''
          Enable nix flakes.
        '';
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.flakes.enable {
      nix.package                = pkgs.nixFlakes;
      nix.extraOptions           = '' experimental-features = nix-command flakes '';
    })
    (lib.mkIf cfg.gc.enable {
      nix.autoOptimiseStore = true;
      nix.settings.auto-optimise-store = lib.mkDefault true;
      nix.gc.automatic = lib.mkDefault true;
      nix.gc.options = lib.mkDefault "--delete-older-than 10d";
    })
    (lib.mkIf (cfg.allowedUnfree != []) {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.allowedUnfree;
    })
  ];
}
