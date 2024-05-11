let 
    enableServers = serves: builtins.listToAttrs 
        (builtins.map 
          (server: 
            {
              name = "${server}.enable";
              value = true;
            }
          )
          plugins
        );
in {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          gd = "definition";
          gD = "declaration";
          gr = "references";
          K = "hover";
          "<leader>D" = "type_defainition";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
        extra = [
          {
            action = "function() vim.lsp.buf.format { async = true } end";
            key = leader "F";
            lua = true;
          }
        ];
      };
      servers = enableAll [
        "cssls"
        "ccls"
        "elmls"
        "html"
        "htmx"
        "nil_ls"
        "nushell"
        "rust-analyzer"
        "svelte"
        "zls"
      ];
    };

    lspkind = {
      enable = true;
      cmp.enable = true;
    };
  };
}
