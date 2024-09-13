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
  };

  simple-rust = pkgs.mkShell {
    packages = with pkgs; [
      rustc
      cargo
      rust-analyzer
      rustfmt
    ];
  };

  csharp9 = pkgs.mkShell {
    packages = with pkgs; [
        dotnetCorePackages.sdk_8_0
        csharp-ls
    ];
  };
}
