{ config, pkgs, self, ...}: {
    nix.package                = pkgs.nixFlakes;
    nix.extraOptions           = '' experimental-features = nix-command flakes '';
    nixpkgs.config.allowUnfree = true;
}
