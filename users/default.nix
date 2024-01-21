{
  home-manager,
  self,
  nixpkgs,
  hyprland,
  ...
} @ inputs: let
  inherit (home-manager.lib) homeManagerConfiguration;
  lib = self.lib;

  mkUserHm = {
    name,
    pkgs ? nixpkgs,
    overlays ? [],
    system ? "x86_64-linux",
  }: let
      # User hm config.
      homeDecl = import ./${name}/home.nix;
      # Known informations.
      known = {
        config = {
          nixpkgs.overlays = overlays;
          home = {
            homeDirectory = "/home/${name}";
            username = name;
            stateVersion = "22.11";
          };
        };
      };

      # The argument to pass to homeManagerConfiguration.
      hm-argset = {
        pkgs = pkgs.legacyPackages.${system};
        modules = [homeDecl known hyprland.homeManagerModules.default] ++ (__attrValues self.homeManagerModules) ++ (__attrValues self.mixedModules);
      };

    in {${name} = homeManagerConfiguration hm-argset;} ;

  mkUsers = users: let
    userHms = map mkUserHm users;
  in
    lib.pipe users [
      (__zipAttrsWith (_: v: __head v))
      (mkUserHm)
    ];
in mkUsers [{name = "adml";}]
