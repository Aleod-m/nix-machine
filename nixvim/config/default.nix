{pkgs}: {
  import = [
    ./keymaps.nix
    ./options.nix
    ./autocmds.nix
    ./filetypes.nix
    ./plugins
    ./languages
  ];

  programs.nixvim = {
    enable = true;
  };
}
