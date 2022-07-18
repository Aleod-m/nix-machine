{ self, lib, config, pkgs, ...}:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./fr-workman-p.xkb} $out
  '';
in {
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
  services.xserver.extraLayouts.fr-workman-p = {
    description = "Fench variation on the workman-p layout";
    languages = [ "fr" ];
    symbolsFile = "${self}/system/fr-workman-p.xkb";
  };
}
