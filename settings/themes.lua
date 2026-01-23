require("catppuccin").setup({
  transparent_background = true,
})

require("tokyonight").setup({
  transparent = true,
})

require("kanagawa").setup({
  transparent = true,
})

require("onedark").setup({
  style = "darker",
  transparent = true,
})

require("rose-pine").setup({
    variant = "auto",               -- auto, main, moon, dawn
    styles = {
        transparency = true,          -- enable transparent style
    },
})

require("ashen").setup({
  transparent = true,
})

vim.g.gruvbox_transparent_bg = 1

-- Themery config 
require("themery").setup({
  themes = {
    { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
    { name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
    { name = "Tokyonight Night", colorscheme = "tokyonight-night" },
    { name = "OneDark", colorscheme = "onedark" },
    { name = "Gruvbox", colorscheme = "gruvbox" },
    { name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" }, 
    { name = "Kanagawa Wave", colorscheme = "kanagawa-wave" }, 
    { name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" }, 
    { name = "Rose Pine", colorscheme = "rose-pine" },
    { name = "Noctis Bordo", colorscheme = "noctis_bordo" },
    { name = "Noctis Uva", colorscheme = "noctis_uva" },
    { name = "Noctis Viola", colorscheme = "noctis_viola" },
    { name = "Ashen", colorscheme = "ashen" },
    
  }, -- Your list of installed colorschemes.
  livePreview = true,
})

