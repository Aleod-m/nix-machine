{
  programs.nixvim.autoCmd = [
    # Remove trailing whitespace on save
    {
      event = "BufWrite";
      command = "%s/\\s\\+$//e";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "html"
        "markdown"
      ];
      command = "setlocal spell spelllang=en,fr";
    }

    # Try reloading the buffers if cursor isn't moving.
    {
        event = ["CursorHold", "CursorHoldI"];
        command = "checktime";
    }

    # Equalize the splits if terminal gets resized.
    {
        event = "VimResized";
        command = "wincmd =";
    }
  ];
}
