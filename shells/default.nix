pkgs: {
  default = pkgs.mkShell {
    # All the programs i need to edit my config.
    packages = with pkgs; [
      # The nix lsp i use.
      nil
      # to run the nix flake commands.
      just
      nushell
    ];

    DIRENV_LOG_FORMAT = "";
  };

  simple-rust = pkgs.mkShell {
    packages = with pkgs; [
      rustc
      cargo
      rust-analyzer
    ];
  };

  csharp.net9 = pkgs.mkShell {
    packages = with pkgs; [
        dotnetCoprePackages.sdk_9_0
        omnisharp-roslyn
    ];
  };
}
