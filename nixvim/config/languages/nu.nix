{pkgs, ...}@inputs: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      languageRegister.nu = "nu";
      grammarPackages = [
        (pkgs.tree-sitter.buildGrammar {
          language = "nu";
          version = input.tree-sitter-nu.rev;
          src = input.tree-sitter-nu;
        })
      ];
    };

    lsp.enabledServers = ["nushell"];
  };
}
