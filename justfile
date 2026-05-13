
alias s := switch
switch target='all' nixopt='':
	[[ "i-all i-os" == *"i-{{target}}"* ]] && nh os switch .# -- {{nixopt}} || true 
	[[ "i-all i-home" == *"i-{{target}}"* ]] && nh home switch .# -- {{nixopt}} || true

alias u := update
update input='all': 
	[["i-all" == *"i-{{input}}"* ]] && nix flake update || nix flake update {{input}}


alias r := registry 
registry:
	nix registry remove nix-machine
	nix registry add nix-machine "git+file://$(pwd)"

test-nv:
	[ ! -d ~/.config/nvim-test ] && ln --symbolic $(realpath ./users/modules/nvim/config/) ~/.config/nvim-test || true
	NVIM_APPNAME=nvim-test nvim 
	[ -d ~/.config/nvim-test ] && rm ~/.config/nvim-test
