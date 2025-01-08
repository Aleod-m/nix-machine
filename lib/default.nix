_inputs: let
  inputs = _inputs // {rootPath = ../.;};
in {
  inherit (inputs) rootPath;
  mk = import ./mk.nix inputs;
  enable = import ./enable.nix inputs;
}
