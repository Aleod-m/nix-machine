
alias s := switch
switch target='all' nixopt='':
	[[ "i-all i-os" == *"i-{{target}}"* ]] && nh os switch .# -- {{nixopt}} || true 
	[[ "i-all i-home" == *"i-{{target}}"* ]] && nh home switch .# -- {{nixopt}} || true

alias u := update
update target='all' nixopt='':
	nix flake update
	[[ "i-all i-os" == *"i-{{target}}"* ]] && nh os switch .# -- {{nixopt}} || true
	[[ "i-all i-home" == *"i-{{target}}"* ]] && nh home switch .# -- {{nixopt}} || true
	

test-nv:
	[ ! -d ~/.config/nvim-test ] && ln --symbolic $(realpath ./users/modules/nvim/config/) ~/.config/nvim-test || true
	NVIM_APPNAME=nvim-test nvim 
	[ -d ~/.config/nvim-test ] && rm ~/.config/nvim-test
