{lib, config, pkgs, ...}:
let
  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./workman-p-fr.xkb} $out
  '';
in {
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
}
