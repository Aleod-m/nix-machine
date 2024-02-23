{pkgs, helpers, ...}@inputs: {
  program.nixvim.plugins = {
    extraPlugins = [
      pkgs.vimPlugins.lush-nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "vim-tup";
        src = inputs.konokai;
      })
    ];

    noice.enable = true;
    lualine = {
      enable = true;
      theme = helpers.mkRaw "require'konokai.themes'.lualine";
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          { 
            name = "filename";
            file_status = true;
            path = 1;
            symbols = {
              modified = " ";
              readonly = " ";
              unnamed = "NONAME";
            };
          }
          "branch"
        ];
        lualine_c = ["diff" "diagnostics"];
        lualine_x = ["encoding" {name = "filetype"; colored = true; }];
        lualine_y = [];
        lualine_z = ["location"];
      };
      inactiveSections = {
        lualine_a = [];
        lualine_b = [];
        lualine_c = ["filename"];
        lualine_x = ["location"];
        lualine_y = [];
        lualine_z = [];
      };
    };
  };
}
