set shell := ["nu", "-c"]

show-trace := if env_var_or_default("SHOW_TRACE", "0") == "1" {
    "--show-trace" 
} else { 
    "" 
}

default: 
    just --list

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
    home-manager {{cmd}} {{show-trace}} --flake .

nos cmd:
    @match {{cmd}} { \
        "switch" | "boot" => { sudo nixos-rebuild {{cmd}} {{show-trace}} --flake ".#nixos-pc" }, \
        _ => { nixos-rebuild {{cmd}} {{show-trace}} --flake ".#nixos-pc" } \
    } \

