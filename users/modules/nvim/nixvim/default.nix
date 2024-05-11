{...}: {
    imports = [
        ./keymaps.nix
        ./options.nix
        ./options.nix
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
    }
}
