let g:floaterm_position = 'bottomright'
let g:floaterm_width = 0.5
let g:floaterm_height = 0.6
let g:floaterm_title = 'Terminal $1/$2'
let g:floaterm_wintype = 'float'
let g:floaterm_rootmarkers = ['.pro']
let g:floaterm_autoclose = 1
let g:floaterm_transparent = 0.6


" Set floaterm window's background to black
hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guifg=orange guibg=cyan

nnoremap <silent> <F1> :FloatermNew --cwd=<buffer><CR>

tnoremap <silent> <F2> <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <F2> :FloatermToggle<CR>
