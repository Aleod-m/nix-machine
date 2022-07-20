{ pkgs, ... }: {
  nix.package                = pkgs.nixFlakes;
  nix.extraOptions           = '' experimental-features = nix-command flakes '';
  nix.autoOptimiseStore      = true;
  nixpkgs.config.allowUnfree = true;
}
