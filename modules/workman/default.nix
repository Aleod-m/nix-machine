{lib, config, pkgs, ...}: {
  services.xserver.extraLayouts.fr-workman-p ={
    description = "Fench variation on the workman-p layout";
    languages = [ "fr" ];
    symbolsFile = ./fr-workman-p.xkb;
  };
}
