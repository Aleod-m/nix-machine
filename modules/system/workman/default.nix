_: { config, ...}: {
  services.xserver.extraLayouts.fr-workman-p = {
    description = "Fench variation of the workman-p layout";
    languages = [ "fr" ];
    symbolsFile = ./. + "/fr-workman-p.xkb";
  };
}
