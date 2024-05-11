with (../helpers.nix); {
  programs.nixvim.plugins = enablePluginsWithSettings {
    neogit.mappings.popup = {
      "l" = false;
      "L" = "LogPopup";
      "t" = false;
      "T" = "TagPopup";
    };

    gitsigns.numhl = true;
  };
}
