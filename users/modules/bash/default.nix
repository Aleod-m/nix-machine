{pkgs, ...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = __readFile ./extra.sh;
    shellAliases = let
      eza = "${pkgs.eza}/bin/eza ";
      git = "${pkgs.git}/bin/git ";
    in {
      # ls replacement
      ls = eza;
      ld = eza + "-d";
      la = eza + "-a -l";
      lg = eza + "-l --git --header";
      lga = eza +"-a -l --git --header";
      
      # git
      ga = git + "add";
      gA = git + "add --all";
      gcm = git + "commit -m";
      gco = git + "checkout";
      gca = git + "commit --amend -m";
      gs = git + "status";
      gl = git + "log --oneline -n 10";
      gf = git + "fetch";
      gp = git + "pull";
      gd = git + "diff";
    };
  };
}
