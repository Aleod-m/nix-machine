{lib, config, pkgs, self, ...}: {
  services.xserver.extraLayouts.fr-workman-p ={
    description = "Fench variation on the workman-p layout";
    languages = [ "fr" ];
    symbolsFile = "${self}/modules/workman/fr-workman-p.xkb";
  };
}
