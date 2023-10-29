# User Directory
In this directory you can create users.
Each user have a directory with these two files required and a directory:
- home.nix 
- default.nix

## default.nix
This file is intended to be edited by the administrator of the system only. It contains the user description and groups.

Here is an exemple of a user with sudo and basic rights: 
```nix
{ config, lib, ... }: {
  users.users.sudoer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
  };
}
```

## home.nix
This file is to be edited by the user. It contains the home configuration.
All the modules contained in the folder `modules/home` can be imported and used.
