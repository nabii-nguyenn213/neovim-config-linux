set nocompatible
filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')
    " Theme 
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'ellisonleao/gruvbox.nvim'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'rose-pine/neovim'
    Plug 'talha-akram/noctis.nvim'
    Plug 'ficd0/ashen.nvim'

    " Theme picker 
    Plug 'zaldih/themery.nvim'

    " Dashboard
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-mini/mini.icons'
    Plug 'folke/snacks.nvim'
    Plug 'folke/lazy.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Better command 
    Plug 'MunifTanjim/nui.nvim'
    Plug 'rcarriga/nvim-notify'
    Plug 'folke/noice.nvim'

    " File Browser
    Plug 'ryanoasis/vim-devicons'

    " Fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Terminal
    Plug 'voldikss/vim-floaterm'
    Plug 'deresmos/nvim-term'

    " Code intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'jiangmiao/auto-pairs'

    " Comment 
    Plug 'numToStr/Comment.nvim'
    Plug 'Djancyp/better-comments.nvim'

    " Anaconda
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kmontocam/nvim-conda'

    " multicursors
    Plug 'terryma/vim-multiple-cursors'

    " Markdown
    Plug 'MeanderingProgrammer/render-markdown.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " If you have nodejs
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

    " For ipynb file 
    Plug 'luk400/vim-jukit' 

    " Typing 
    Plug 'nvzone/volt'
    Plug 'nvzone/typr'

    " Chatbot
    Plug 'RayenMnif/tgpt.nvim'

    " CSV viewer 
    Plug 'hat0uma/csvview.nvim'

    " Minimap 
    Plug 'Isrothy/neominimap.nvim', { 'tag': 'v3.15.4' }
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'echasnovski/mini.diff'

    " Code fold
    Plug 'chrisgrieser/nvim-origami'

call plug#end()

let mapleader = " "
set tabstop=4
set shiftwidth=4
set expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
set number 
set relativenumber 
set termguicolors
set noswapfile
set cursorline
highlight Cursorline cterm=bold ctermbg=black
set nowrap

let g:AutoPairsCompatibleMaps = 0
" Font / Font size 
set guifont=Fira\ Code:h8 

" Themery --- Theme picker
nnoremap <leader>tt :Themery<CR>

" =========================
" Transparency (GLOBAL)
" =========================
function! SetTransparent()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight NormalFloat guibg=NONE ctermbg=NONE
    highlight FloatBorder guibg=NONE ctermbg=NONE
endfunction

call SetTransparent()

augroup TransparentBG
    autocmd!
    autocmd ColorScheme * call SetTransparent()
augroup END

" vim airline 
let g:airline_theme = 'violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Set path for jukit
" let g:python3_host_prog = '~/yes/envs/nvim-jukit/bin/python'
" let g:loaded_python3_provider = 0
let g:python3_host_prog = expand('~/yes/envs/nvim/bin/python')
" let g:python3_host_prog = '/home/nabinguyen/yes/envs/nvim/bin/python'

"--------------------------------------------------------------------------------------------------------------- " 
if filereadable(expand('~/.config/nvim/settings/jukit.vim'))
    source ~/.config/nvim/settings/jukit.vim
endif

" Extended settings
let nvim_settings_dir = '~/.config/nvim/settings/'
execute 'source '.nvim_settings_dir.'floaterm.vim'
execute 'source '.nvim_settings_dir.'coc.vim'
execute 'source '.nvim_settings_dir.'mappings.vim'
execute 'source '.nvim_settings_dir.'fzf.vim'
execute 'source '.nvim_settings_dir.'multicursors.vim'
execute 'source '.nvim_settings_dir.'neovimconda.vim'
execute 'source '.nvim_settings_dir.'markdown.vim'
execute 'source '.nvim_settings_dir.'jukit.vim'

execute 'luafile '.nvim_settings_dir.'snacks.lua'
execute 'luafile '.nvim_settings_dir.'noice.lua'
execute 'luafile '.nvim_settings_dir.'typr.lua'
execute 'luafile '.nvim_settings_dir.'csvview.lua'
execute 'luafile '.nvim_settings_dir.'minimap.lua'
execute 'luafile '.nvim_settings_dir.'origami.lua'


" LUA 
:lua << EOF
require('Comment').setup({
    mappings = {
    basic = true,
    extra = false,
    }
})

require("nvim-autopairs").setup({
  check_ts = true,
  map_cr = false, 
})

require("which-key").setup(

)

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

require('nvim-treesitter.config').setup({
  highlight = { enable = true },
})

require('better-comment').Setup({
    tags = {
        {
            name = "TODO",
            fg = "white",
            bg = "#0a7aca",
            bold = true,
            virtual_text = "",
        },
        {
            name = "FIX",
            fg = "white",
            bg = "#f44747",
            bold = true,
            virtual_text = "This is virtual Text from FIX",
        },
        {
            name = "WARNING",
            fg = "#FFA500",
            bg = "",
            bold = false,
            virtual_text = "This is virtual Text from WARNING",
        },
        {
            name = "!",
            fg = "#f44747",
            bg = "",
            bold = true,
            virtual_text = "",
        }

    }
})

local function hex(n) return string.format("#%06x", n) end

local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
local bg = normal.bg and hex(normal.bg) or "#000000"

require("notify").setup({
  background_colour = bg,
})

require("quest")

require("tgpt").setup({
    buffer_height_ratio = 1.0,
    buffer_width_ratio = 0.4,
})
vim.keymap.set("n", "<leader>cc", "<cmd>TgptChat<CR>", { silent = true, desc = "Typr stats" })
vim.keymap.set("n", "<leader>cr", "<cmd>TgptRateMyCode<CR>", { silent = true, desc = "Typr stats" })
vim.keymap.set("n", "<leader>cb", "<cmd>TgptCheckForBugs<CR>", { silent = true, desc = "Typr stats" })


EOF
