{nixpkgs, ...}: let
  lib = nixpkgs.lib;
in {
  services = ss: rest: let
    enableService = map (s: lib.setAttrByPath ["services" s "enable"] true) ss;
  in
    lib.lists.foldl lib.attrsets.recursiveUpdate rest enableService;

  programs = ps: rest: let
    enableProgram = map (s: lib.setAttrByPath ["programs" s "enable"] true) ps;
  in
    lib.lists.foldl lib.attrsets.recursiveUpdate rest enableProgram;
}
