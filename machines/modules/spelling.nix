{pkgs, ...}: {
	# Spelling support at the os level.
	services.languagetool.enable = true;
  environment.systemPackages = with pkgs; [
		hunspell
		hunspellDicts.fr-any
	];
}
