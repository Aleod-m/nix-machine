{pkgs, ...}:
let
  exa = "${pkgs.exa}/bin/exa ";
  git = "${pkgs.git}/bin/git ";
in {
  # ls replacement
  ls = exa;
  ld = exa + "-d";
  la = exa + "-a -l";
  lg = exa + "-l --git --header";
  lga = exa +"-a -l --git --header";
  # TODO l.

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
  # archives
}
