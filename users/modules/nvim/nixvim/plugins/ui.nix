{pkgs, lib, ...}:
with (import ../helpers.nix); {
    programs.nixvim = {
      extraPlugins = [
        (pkgs.vimUitls.buildVimPlugin {
          owner = "Aleod-m";
          repo = "konokai";
          rev = "0ed1cc3458ec6db074483aec9da4131a31213052";
          hash = lib.fakeHash;
        })
      ];
      colorscheme = "konokai";

      plugins = {
        lualine = {
          enable = true;
          theme = "require'konokai.themes'.lualine";
          winbar = {
            lualine_a = { "mode" };
            lualine_b = [
              {
                name = "filename";
                file_status = true;
                path = 1;
                symbols = {
                  modified=" ";
                  readonly=" ";
                  unnamed="NONAME";
                };
              }
              "branch"
            ];
            lualine_c = ["diff", "diagnostics"];
            lualine_x = ["encoding", {"filetype", colored=true}];
            lualine_y = [];
            lualine_z = ["location"]
          };
          inactive_winbar = {
            lualine_a = [];
            lualine_b = [];
            lualine_c = ["filename"];
            lualine_x = ["location"];
            lualine_y = [];
            lualine_z = [];
          };
        };
      };
    };
};
