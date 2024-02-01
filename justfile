set shell := ["nu", "-c"]

show-trace := if env_var_or_default("SHOW_TRACE", "0") == "1" {
    "--show-trace" 
} else { 
    "" 
}

update:
    @nix flake update

default: 
    @just ball
    @just sall

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
    {{ if cmd =~ "switch|boot" {"sudo"} else {""} }} nixos-rebuild {{cmd}} {{show-trace}} --flake .#nixos-pc
    
