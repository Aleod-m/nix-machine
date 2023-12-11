{
  home-manager,
  self,
  nixpkgs,
  hyprland,
  ...
} @ inputs: let
  inherit
    (home-manager.lib)
    homeManagerConfiguration
    ;
  mkUserHm =
    {
      name,
      pkgs ? nixpkgs,
      overlays ? [],
      system ? "x86_64-linux",
    }: let
      home =
        import ./${name}/home.nix
        # Known informations.
        ;
      known = {
        config = {
          nixpkgs.overlays =
            overlays;
          home = {
            homeDirectory = "/home/${name}";
            username =
              name;
            stateVersion = "22.11";
          };
        };
      };
      hm-argset = {
        pkgs =
          pkgs.legacyPackages.${system};
        modules =
          [home known hyprland.homeManagerModules.default] ++ (__attrValues self.homeManagerModules) ++ (__attrValues self.mixedModules);
      };
    in {${name} = homeManagerConfiguration hm-argset;}
    # If a user is declared multiple times takes the first declaration.
    ;
  mkUsers = users: let
    userHms = map mkUserHm users;
  in
    __zipAttrsWith (_: v: __head v) userHms;
in
  mkUsers [{name = "adml";}]
