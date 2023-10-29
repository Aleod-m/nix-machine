{ nixpkgs-stable 
, hyprland
, self
, ...
}: let inherit (nixpkgs-stable.lib) nixosSystem
  # Function to create a computer with some users.
  ; mkComputer = 
    { hostName
    , modules
    , users 
    , homeManager ? false
    , pkgs ? nixpkgs-stable
    , system
    } : let 
      nixos-argset = 
        { inherit system
        ; modules = 
          [ ./${hostName} 
            { networking.hostName = hostName; }
            hyprland.nixosModules.default
          ] 
          # Add my custom nixos + mixed modules. 
          ++ (__attrValues self.nixosModules)
          ++ (__attrValues self.mixedModules)

          # add all the selected configuration modules. 
          ++ (map (mod: import ./modules/${mod}) modules)
          # add all the selected users 
          ++ (map (user: import ../users/${user}) users)

        ; }
    ; in { ${hostName} = nixosSystem nixos-argset; }

  # Conveignance function to create all my systems
  ; mkComputers = computers:
    let comps = map mkComputer computers;
    in __zipAttrsWith (_: v: __head v) comps 

; in mkComputers 
  # My laptop (i know its caled pc but its a laptop that doesn't move much).
  [ { hostName = "nixos-pc"
    ; system = "x86_64-linux" 
    ; users = [ "adml" ]
    ; modules = 
      [ "base.nix"
        "sound.nix"
        "ssh.nix"
        "nix.nix"
        "net.nix"
        "nvidia.nix"
        "hyprland.nix"
        "lightdm.nix"
        "docker.nix"
        "tailscale.nix"
      ]
    ; }
  ]
