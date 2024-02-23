{...}: {
  programs.nixvim = {
    autoCmd = [
      {
        event = ["CursorHold" "CursorHoldI"];
        command = "checktime";
      }
      {
        event = "VimResized";
        command = "wincmd =";
      }
    ];
  };
}
