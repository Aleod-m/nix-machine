{
  withSystem,
  inputs,
  ...
}: {
  flake = withSystem "x86_64-linux"({system, pkgs, lib, ...}: 
  let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mkComputer = hostname: modules: {
      ${hostname} = nixosSystem {
        modules = [
          ./${hostname}
        ] ++ (map (mod: ./modules/${mod}) modules);
      };
    };
    mkComputers = __zipAttrsWith
      (name: val: __head vals)
      (map mkComputer sys);
  in mkComputers [
        { hostname = "nixos-pc"; modules = [
            "base.nix"
            "sound.nix"
            "nix.nix"
            "nvidia.nix"
        ]
    ]
  }
}
