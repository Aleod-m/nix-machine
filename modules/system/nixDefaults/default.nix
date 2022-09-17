_: { pkgs, lib, config, ... }: 
let
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
    nix.package                = pkgs.nixFlakes;
    nix.extraOptions           = '' experimental-features = nix-command flakes '';
    nix.autoOptimiseStore      = true;
    nixpkgs.config.allowUnfree = true;
    nix.gc.automatic = lib.mkDefault true;
    nix.settings.auto-optimise-store = lib.mkDefault true;
    nix.gc.options = lib.mkDefault "--delete-older-than 10d";
    nixpkgs.config.allowUnfreePredicate = lib.mkIf (cfg.allowedUnfree != []) (pkg: __elem (lib.getName pkg) allowed);
  };
}
