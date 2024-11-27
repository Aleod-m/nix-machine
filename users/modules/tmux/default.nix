{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      resurrect
    ];
  };
  programs.tmate.enable = true;
}
