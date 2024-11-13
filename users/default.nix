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
    modules ? [],
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
        # Home manager manages itself.
        programs.home-manager.enable = true;
      };
    };

    # The argument to pass to homeManagerConfiguration.
    hm-argset = {
      pkgs = pkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit system inputs;
      };
      modules =
        [homeDecl known hyprland.homeManagerModules.default]
        # Add my custom home-manager and mixed modules.
        ++ (__attrValues self.homeManagerModules)
        ++ (__attrValues self.mixedModules)
        # add all the selected configuration modules.
        ++ (map (mod: import ./modules/${mod}) modules);
    };
  in {${name} = homeManagerConfiguration hm-argset;};

  mkUsers = users:
    lib.pipe users [
      (map mkUserHm)
      (__zipAttrsWith (_: v: __head v))
    ];
in
  mkUsers [
    {
      name = "adml";
      modules = ["nvim" "hyprland" "nushell" "kitty wallpapers"];
    }
    {
      name = "adrien";
      modules = ["nvim" "hyprland" "nushell" "wallpapers" "kitty" "bash"];
    }
  ]
