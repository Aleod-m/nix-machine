let 
    # Remapping utitlities.
    _map = mode: key: action: let 
        lua = (__typeOf action == "set") && (__hasAttr lua action);
    in {
        inherit mode key lua;
        action = if lua then action.lua else action;
        options = {
            silent = true;
        }
    };

    enablePluginsWithSettigns = __mapAttrs (_: settings: {
        {
            enable = true;
            inherit settings;
        };
    });
in {
    leader = key: "<Space>${key}";
    ctrl = key: "<C-${key}>";
    alt = key: "<M-${key}>";
    lua = action: { lua = action; };
    cmd = cmd: "<Cmd>${cmd}<Cr>";
    
    inherit _map;
    nvmap = _map ["n" "v"];
    nmap = _map ["n"];
    vmap = _map ["v"];
    imap = _map ["i"];

    enableAll = toEnable:
      builtins.listToAttrs 
        (builtins.map (enabing: 
          {
            name = "${enabling}.enable";
            value = true;
          }
          toEnable
        )
      );
}
