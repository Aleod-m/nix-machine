_inputs: let
  inputs = _inputs // {rootPath = ../.;};
  lib = inputs.nixpkgs.lib;

in {
  inherit (inputs) rootPath;
  mk = import ./mk.nix inputs;
  enable = import ./enable.nix inputs;

  import = basePath: mods:
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
    ];
}
