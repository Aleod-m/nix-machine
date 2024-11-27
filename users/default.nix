{
  home-manager,
  self,
  nixpkgs,
  hyprland,
  agenix,
  ...
} @ inputs: let
  inherit (home-manager.lib) homeManagerConfiguration;
  lib = self.lib;

  mkUserHm = {
    username,
    modules ? [],
    pkgs ? nixpkgs,
    overlays ? [],
    system ? "x86_64-linux",
  }: let
    # User hm config.
    homeDecl = import ./${username}/home.nix;
    # Known informations.
    known = {
      config = {
        nixpkgs.overlays = overlays;
        home = {
          homeDirectory = "/home/${username}";
          stateVersion = "22.11";
          inherit username;
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
      modules = [
        known 
        homeDecl 
        hyprland.homeManagerModules.default 
        agenix.homeManagerModules.default
        # Add my custom home-manager and mixed modules.
      ] ++ (__attrValues self.homeManagerModules)
        ++ (__attrValues self.mixedModules)
        # add all the selected configuration modules.
        ++ (map (mod: import ./modules/${mod}) modules);
    };
  in {${username} = homeManagerConfiguration hm-argset;};

  mkUsers = users:
    lib.pipe users [
      (map mkUserHm)
      (__zipAttrsWith (_: v: __head v))
    ];
in
  mkUsers [
    {
      username = "adml";
      modules = [
        "nvim"
        "hyprland"
        "nushell"
        "kitty"
        "wallpapers"
      ];
    }
    {
      username = "adrien";
      modules = [
        "nvim"
        "hyprland"
        "nushell"
        "wallpapers"
        "kitty"
        "bash"
        "shell-utils"
        "tmux"
      ];
    }
  ]
