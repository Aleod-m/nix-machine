with (import ./helpers.nix) {
  programs.nixvim.keymaps = [
    nvmap "t" "gk"
    nvmap "k" "gj"
    nvmap "H" "^"
    nvmap "L" "$"
    nmap "cH" "c^"
    nmap "cL" "c$"
    nmap "dH" "d^"
    nmap "dL" "d$"
    nmap "yH" "y^"
    nmap "yL" "y$"
    # Delete without poluting yank register.
    nvmap (leader "X") "\"_x"
    nvmap (leader "D") "\"_d"
    # Add a second register accessible with leader + (y/p)
    nvmap (leader "y") "\"py"
    nvmap (leader "p") "\"pp"
    # Yank to / from system register.
    nvmap (leader "Y") "\"pY"
    nvmap (leader "P") "\"pP"
    # Highlight pasted. 
    nmap (leader "vp") "'[v']"
    # Remove searche highlight.
    nmap (leader "nh") (cmd "noh")
    nmap (leader "w") "${cmd "w"}zR"
    # Auto insert closing delimiters.
    imap "{<Cr>" "{<Cr>}<Esc>O"
    imap "[<Cr>" "[<Cr>]<Esc>O"
    imap "(<Cr>" "(<Cr>)<Esc>O"
    # Insert accent with alt k.
    imap (alt "k") (ctrl "k")

    # Move lines of codes. 
    imap (ctrl "h") (ctrl "D")
    imap (ctrl "l") (ctrl "T")
    imap (ctrl "k") "<Esc>${cmd "m .+1"}i"
    imap (ctrl "t") "<Esc>${cmd "m .-2"}i"

    nmap (ctrl "h") "<<"
    nmap (ctrl "l") ">>"
    nmap (ctrl "k") "<Esc>${cmd "m .+1"}i"
    nmap (ctrl "t") "<Esc>${cmd "m .-2"}i"

    nmap (ctrl "h") "<gv"
    nmap (ctrl "l") ">gv"
    nmap (ctrl "k") "${cmd "m'>+"}gv"
    nmap (ctrl "t") "${cmd "m-2"}gv"
  
    # Diagnostics navigation.
    nmap (leader "dn") (lua "vim.diagnostic.got_next")
    nmap (leader "dp") (lua "vim.diagnostic.got_prev")
    nmap (leader "dl") (lua "vim.diagnostic.open_float")
    nmap (leader "ft") (lua ''
      function()
      require('telescope.builtin').live_grep({
        default_text="TODO",
        initial_mode="normal"
      })
      end
    '')
  ];
}
