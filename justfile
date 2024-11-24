set shell := ["nu", "-c"]

default: 
    @just --list

update input:
    @if {{input}} == "all" { \
        nix flake update \
    } else { \
        nix flake lock --update-input {{input}} \
    }

check:
    nix flake check

# build commands
ball:
    @just hm build
    @just nos build

sall:
    @just hm switch
    @just nos switch

hm cmd:
    home-manager {{cmd}} --flake .

nos cmd:
    @match {{cmd}} { \
        "switch" | "boot" => { sudo nixos-rebuild {{cmd}} --flake ".#" }, \
        _ => { nixos-rebuild {{cmd}} --flake ".#nixos-pc" } \
    } \

