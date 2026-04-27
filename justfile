
nv:
	[ ! -d ~/.config/nvim-test ] && ln --symbolic $(realpath ./users/modules/nvim/config/) ~/.config/nvim-test || true
	NVIM_APPNAME=nvim-test nvim 
	[ -d ~/.config/nvim-test ] && rm ~/.config/nvim-test
