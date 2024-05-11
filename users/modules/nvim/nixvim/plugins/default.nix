with (import ../helpers.nix); {
  imports = [
    ./harpoon.nix
    ./lsp.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = enableAll [
        "commentary"
        "oil"
    ];
    keymaps = [
        nmap "-" (cmd "Oil")
    ];
  };
}
