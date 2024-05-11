with (import ../helpers.nix); {
  program.nixvim.plugins.harpoon = {
    enable = true;
    keymapsSilent = true;
    keymaps = {
      addFile = leader "a";
      toggleQuickMenu = ctrl "e";
      navFile = {
        "1" = ctrl "1";
        "2" = ctrl "2";
        "3" = ctrl "3";
        "4" = ctrl "4";
        "5" = ctrl "5";
      };
    };
  };
}
