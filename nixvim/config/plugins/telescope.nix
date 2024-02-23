{...}: let
  leader = keys: "<Leader>" ++ keys; 
in {

    programs.nixvim.plugins.telescope = {
      enable = true;
      extension = {
        ui-selecet.enable = true;
        project-nvim.enable = true;
      };

      extraOptions = {
        pickerrs = {
          current_buffer_fuzzy_find = {
            sorting_strategy = "ascending";
            prompt_position = "top";
          };
          defaults = {
            prompt_prefix = " ";
          };
        };
      };

      keymaps = {
        ${ leader "ff" } = { action = find_files;   };
        ${ leader "fs" } = { action = live_grep;    };
        ${ leader "fgf"} = { action = git_files;    };
        ${ leader "fgb"} = { action = git_branches; };
        ${ leader "fb" } = { action = buffers;      };
        ${ leader "dl" } = { action = diagnostics;  };
      };
    };
}
