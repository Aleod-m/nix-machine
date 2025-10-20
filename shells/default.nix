pkgs: {
  default = pkgs.mkShell {
    # All the programs i need to edit my config.
    packages = with pkgs; [
      # The nix lsp i use.
      nil
      # Lua lsp for nvim.
      lua-language-server
    ];
  };

  zig = pkgs.mkShell {
    packages = with pkgs; [
      zig
      zls
    ];
  };

  java = pkgs.mkShell {
    packages = with pkgs; [
      jdt-language-server
      jdk17
      maven
      lombok
    ];
    env.JDTLS_JVM_ARGS="-javaagent:${pkgs.lombok}/share/java/lombok.jar";
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
