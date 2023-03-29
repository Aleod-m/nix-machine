{self, home-manager, ...} @ inputs: {
  /* Funciton collecting all the informations for building the nixos system.
   */
  mkComputer = {
    name,
    users,
    system,
    pkgs,
  }: let
    userDefs = map (name: import "${self}/users/${name}" inputs) users;
    config = import "${self}/machines/configs/${name}.nix" inputs;
    hardware = import "${self}/machines/hardware/${name}.nix" inputs;
  in pkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit self;};
    modules = [
      {
        system.stateVersion = "21.11";
        networking.hostName = name;
      } # Configure the hostName from the provided name.
      inputs.kmonad.nixosModules.default
      hardware # Add the hardware config for this machine.
      config # Add the configuration for this machine.
    ] ++ builtins.attrValues self.nixosModules # Add my own modules.
    ++ builtins.attrValues self.mixedModules
    ++ userDefs; # Add the users.
  };

  /* Fonction collecting all the informations for building the home-manager configuration.
   */
  mkUser = {
    username,
    system,
    pkgs,
    overlays ? [],
  }: let
    args = inputs;
    homeConfig = import "${self}/users/${username}/home.nix" inputs;
    homeModules = import "${self}/users/${username}/modules" inputs;
    homeDirectory = "/home/${username}";
  in home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs.legacyPackages.${system};
    modules = [
      homeConfig
      {
        config = {
          nixpkgs.overlays = overlays;
          home = {
            inherit username homeDirectory;
            stateVersion = "22.11";
          };
        };
      }
    ] ++ builtins.attrValues self.homeModules;
  };
}