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
execute 'luafile '.nvim_settings_dir.'themes.lua'
execute 'luafile '.nvim_settings_dir.'comments.lua'
execute 'luafile '.nvim_settings_dir.'tgpt.lua'
execute 'luafile '.nvim_settings_dir.'notify.lua'

execute 'luafile '.nvim_settings_dir.'others.lua'

