{
  home-manager,
  nixpkgs,
  rootPath,
  ...
}: let
  lib = nixpkgs.lib;

  loadModule = basePath: mods:
    let 
      mkModfs = mod:
        let 
          filePath = basePath + /${mod}.nix;
          folderPath = basePath + /${mod}/.;
        in [filePath folderPath];
    in lib.pipe mods [
        (map mkModfs)
        lib.lists.flatten
        (lib.filter (p: (lib.filesystem.pathIsDirectory p) || (lib.filesystem.pathIsRegularFile p)))
        (map (mod: import mod))
    ];

  # Util function for creating a user.
  mkUserHm = inputs: {
    username,
    modules ? [],
    pkgs ? nixpkgs,
    overlays ? [],
    system ? "x86_64-linux",
  }: let
    # User hm config.
    homeDecl = import (rootPath + /users/${username}/home.nix);

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
        inherit (inputs) hyprland agenix mlib system hyprland-plugins hyprlock hyprpaper hypridle zen-browser;
      };
      modules =
        [
          known
          homeDecl
          inputs.hyprland.homeManagerModules.default
          inputs.agenix.homeManagerModules.default
          # Add my custom home-manager and mixed modules.
        ]
        ++ (__attrValues inputs.self.homeManagerModules)
        # add all the selected configuration modules.
        ++ (loadModule (rootPath + /users/modules/.) modules);
    };
  in {${username} = home-manager.lib.homeManagerConfiguration hm-argset;};

  # Function to create a computer with some users.
  mkComputer = inputs: {
    hostName,
    users,
    modules ? [],
    homeManager ? false,
    pkgs ? nixpkgs,
    system,
  }: let
    nixos-argset = {
      inherit system;
      specialArgs = {inherit (inputs) hyprland agenix mlib;};
      modules =
        [
          (rootPath + /machines/${hostName})
          {networking.hostName = hostName;}
          inputs.agenix.nixosModules.default
        ]
        # Add my custom nixos and mixed modules.
        ++ (__attrValues inputs.self.nixosModules)
        # add all the selected configuration modules.
        ++ (loadModule (rootPath + /machines/modules/.) modules)
        ++ (loadModule (rootPath + /users/.) users);
        # add all the selected users
    };
  in {${hostName} = lib.nixosSystem nixos-argset;};
in {
  # Conveignance function to create all my usesrs.
  users = inputs: users:
    lib.pipe users [
      (map (mkUserHm inputs))
      (__zipAttrsWith (_: v: __head v))
    ];

  # Conveignance function to create all my systems
  computers = inputs: computers:
    lib.pipe computers [
      (map (mkComputer inputs))
      (__foldl' (a: b: a // b) {})
    ];

  modules = basePath: names: let
    mkModule = mod: {${mod} = import (rootPath + /modules/${basePath}/${mod}.nix);};
  in
    lib.pipe names [
      (map mkModule)
      (__zipAttrsWith (_: v: __head v))
    ];
}
