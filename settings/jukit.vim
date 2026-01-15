" ============================================================================
" vim-jukit config (kitty + inline plotting)
" File: ~/.config/nvim/settings/jukit.vim
" ============================================================================

" Guard (in case you accidentally source this file twice)
if exists('g:loaded_user_jukit_settings')
  finish
endif
let g:loaded_user_jukit_settings = 1

" ----------------------------------------------------------------------------
" Basic Jukit Options
" ----------------------------------------------------------------------------
" let g:jukit_shell_cmd = 'ipython3'
let g:jukit_shell_cmd = '~/yes/envs/nvim/bin/ipython'

" IMPORTANT for kitty + inline plotting:
let g:jukit_terminal = 'kitty'
let g:jukit_use_kitty = 1

let g:jukit_auto_output_hist = 0
let g:jukit_use_tcomment = 0
let g:jukit_comment_mark = '#'

let g:jukit_mappings = 1
let g:jukit_mappings_ext_enabled = '*'

let g:jukit_notebook_viewer = 'jupyter-notebook'
let g:jukit_convert_overwrite_default = -1
let g:jukit_convert_open_default = -1
let g:jukit_file_encodings = 'utf-8'
let g:jukit_venv_in_output_hist = 1

" ----------------------------------------------------------------------------
" Cell highlighting / syntax
" ----------------------------------------------------------------------------
let g:jukit_highlight_markers = 1
let g:jukit_enable_textcell_bg_hl = 1
let g:jukit_enable_textcell_syntax = 1
let g:jukit_text_syntax_file = $VIMRUNTIME . '/syntax/markdown.vim'
let g:jukit_hl_ext_enabled = '*'

" ----------------------------------------------------------------------------
" Kitty-specific colors / windows
" ----------------------------------------------------------------------------
let g:jukit_output_bg_color  = get(g:, 'jukit_output_bg_color', '')
let g:jukit_output_fg_color  = get(g:, 'jukit_output_fg_color', '')
let g:jukit_outhist_bg_color = get(g:, 'jukit_outhist_bg_color', '#090b1a')
let g:jukit_outhist_fg_color = get(g:, 'jukit_outhist_fg_color', 'gray')

" Keep splits in the same kitty OS window (change to 1 if you want separate OS windows)
let g:jukit_output_new_os_window  = 0
let g:jukit_outhist_new_os_window = 0

" Kill output terminal when exiting nvim (optional, but you had it)
let g:jukit_kill_output_on_exit = 1

" ----------------------------------------------------------------------------
" IPython output saving
" ----------------------------------------------------------------------------
let g:jukit_in_style = 2
let g:jukit_max_size = 20
let g:jukit_show_prompt = 0

" Using ipython => enable saving
let g:jukit_save_output = 1

let g:jukit_clean_outhist_freq = 60 * 10

" ----------------------------------------------------------------------------
" Matplotlib (kitty inline plotting)
" ----------------------------------------------------------------------------
let g:jukit_savefig_dpi = 150
let g:jukit_mpl_block = 1
let g:jukit_custom_backend = -1

" Enable in-terminal plotting (kitty)
let g:jukit_inline_plotting = 1

" DO NOT set g:jukit_mpl_style by calling jukit#util#plugin_path() here.
" We'll set it safely after startup.
let g:jukit_mpl_style = ''

function! s:jukit_resolve_plugin_path() abort
  " 1) Try Jukit's own helper (may error early on some setups)
  try
    let l:p = jukit#util#plugin_path()
    if type(l:p) == v:t_string && !empty(l:p)
      return l:p
    endif
  catch
  endtry

  " 2) Fallbacks for common plugin locations (vim-plug default, etc.)
  for l:p in [
        \ expand('~/.config/nvim/plugged/vim-jukit'),
        \ expand('~/.vim/plugged/vim-jukit'),
        \ ]
    if isdirectory(l:p)
      return l:p
    endif
  endfor

  return ''
endfunction

function! s:jukit_set_kitty_mpl_style() abort
  let l:pp = s:jukit_resolve_plugin_path()
  if !empty(l:pp)
    let g:jukit_mpl_style = l:pp . '/helpers/matplotlib-backend-kitty/backend.mplstyle'
  endif
endfunction

augroup JukitKittyMplStyle
  autocmd!
  autocmd VimEnter * call s:jukit_set_kitty_mpl_style()
augroup END

" ----------------------------------------------------------------------------
" Layout (default)
" ----------------------------------------------------------------------------
let g:jukit_layout = {
    \ 'split': 'horizontal',
    \ 'p1': 0.6,
    \ 'val': [
    \   'file_content',
    \   {
    \     'split': 'vertical',
    \     'p1': 0.6,
    \     'val': ['output', 'output_history']
    \   }
    \ ]
    \ }

" ----------------------------------------------------------------------------
" Key mappings (same as your original)
" ----------------------------------------------------------------------------
nnoremap <leader>os :call jukit#splits#output()<cr>
nnoremap <leader>ts :call jukit#splits#term()<cr>
nnoremap <leader>hs :call jukit#splits#history()<cr>
nnoremap <leader>ohs :call jukit#splits#output_and_history()<cr>
nnoremap <leader>hd :call jukit#splits#close_history()<cr>
nnoremap <leader>od :call jukit#splits#close_output_split()<cr>
nnoremap <leader>sl :call jukit#layouts#set_layout()<cr>

nnoremap <S-CR> :call jukit#send#section(0)<cr>
nnoremap <leader><CR> :call jukit#send#line()<cr>
vnoremap <S-CR> :<C-U>call jukit#send#selection()<cr>
nnoremap <leader>mc :call jukit#send#until_current_section()<cr>
nnoremap <leader>all :call jukit#send#all()<cr>

nnoremap <leader>ma :call jukit#cells#create_below(0)<cr>
nnoremap <leader>mA :call jukit#cells#create_above(0)<cr>
nnoremap <leader>mt :call jukit#cells#create_below(1)<cr>
nnoremap <leader>mT :call jukit#cells#create_above(1)<cr>
nnoremap <leader>md :call jukit#cells#delete()<cr>
nnoremap <leader>mp :call jukit#cells#split()<cr>
nnoremap <leader>mM :call jukit#cells#merge_above()<cr>
nnoremap <leader>mm :call jukit#cells#merge_below()<cr>
nnoremap <leader>mF :call jukit#cells#move_up()<cr>
nnoremap <leader>mS :call jukit#cells#move_down()<cr>
nnoremap <leader>ms :call jukit#cells#jump_to_next_cell()<cr>
nnoremap <leader>mf :call jukit#cells#jump_to_previous_cell()<cr>
nnoremap <leader>ddo :call jukit#cells#delete_outputs(0)<cr>
nnoremap <leader>dda :call jukit#cells#delete_outputs(1)<cr>

nnoremap <leader>np :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
"   - Convert from ipynb to py or vice versa. Argument: Optional. If an argument is specified, then its value is used to open the resulting ipynb file after converting script.
