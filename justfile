set shell := ["nu", "-c"]

show-trace := if env("SHOW_TRACE", "0") == "1" {
    "--show-trace" 
} else { 
    "" 
}

default: 
    @nix flake update
    @just ball
    @just sall

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
    
