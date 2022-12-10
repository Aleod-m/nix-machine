local _ = require("languages.TS")

local languages = {
    rust   = require("languages.settings.rust"),
    c      = require("languages.settings.c"),
    latex  = require("languages.settings.latex"),
    java   = require("languages.settings.java"),
    vue    = require("languages.settings.vue"),
    lua    = require("languages.settings.lua"),
    elm    = require("languages.settings.elm"),
    svelte = require("languages.settings.svelte"),
    wgsl   = require("languages.settings.wgsl"),
    nix    = require("languages.settings.nix"),
}

for _, settings in pairs(languages) do
    require'languages.lsp'.setup(settings)
end
