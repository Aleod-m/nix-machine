{nixpkgs, ...}: let
  lib = nixpkgs.lib;
in {
  services = ss: let
    enableService = map (s: lib.setAttrByPath ["services" s "enable"] true) ss;
  in
    lib.lists.foldl lib.attrsets.recursiveUpdate {} enableService;

  programs = ss: let
    enableProgram = map (s: lib.setAttrByPath ["programs" s "enable"] true) ss;
  in
    lib.lists.foldl lib.attrsets.recursiveUpdate {} enableProgram;
}
