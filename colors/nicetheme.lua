local colorscheme_env = os.getenv("vimcolorscheme")

if colorscheme_global ~= nil then
    require("colorscheme.colorscheme_colors").setup(require("colorscheme.colorscheme_colors." .. colorscheme_global))
elseif colorscheme_env ~= nil then
    require("colorscheme.colorscheme_colors").setup(require("colorscheme.colorscheme_colors." .. colorscheme_env))
else
    require("colorscheme.colorscheme_colors").setup(require("systemcolors"))
end
