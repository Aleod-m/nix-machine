
alias s := switch
switch target='all':
	[[ "i-all i-os" == *"i-{{target}}"* ]] && nh os switch .# || true 
	[[ "i-all i-home" == *"i-{{target}}"* ]] && nh home switch .# || true

alias u := update
update target='all':
	nix flake update
	[[ "i-all i-os" == *"i-{{target}}"* ]] && nh os switch .#
	[[ "i-all i-home" == *"i-{{target}}"* ]] && nh home switch .#
	

test-nv:
	[ ! -d ~/.config/nvim-test ] && ln --symbolic $(realpath ./users/modules/nvim/config/) ~/.config/nvim-test || true
	NVIM_APPNAME=nvim-test nvim 
	[ -d ~/.config/nvim-test ] && rm ~/.config/nvim-test
