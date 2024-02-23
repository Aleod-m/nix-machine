{...}: {
  programs.nixvim = {
    plugins = {
    };
    lsp.enabledServers = ["nil_ls"];
  };
}
