{...}: {
  programs.nixvim.plugins = {
    gitsings.numhl = true;
    neogit = {
      enable = true;
      # For my kbd layout these mappings are anoying.
      mappings = {
        popup = {
          l = false;
          L = "LogPopup";
          t = false;
          T = "TagPopup";
        };
      };
    };
  };
}
