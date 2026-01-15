" NORMAL MODE 

"cursor movement b, c, g*, h, j, k, m, k, q
nnoremap <silent> r h
nnoremap <silent> s j
nnoremap <silent> f k
nnoremap <silent> t l
nnoremap <silent> w ^
nnoremap <silent> p $

nnoremap <silent> n b
nnoremap <silent> e w

nnoremap <silent> gg gg
nnoremap <silent> G G


"undo and redo
nnoremap <silent> z u
nnoremap <silent> <C-z> <C-r>
"copy and paste and replace 
nnoremap <silent> u p 
nnoremap <silent> U "+p
vnoremap <silent> U "+p
nnoremap <silent> Y "+y
nnoremap <silent> y y
nnoremap <silent> yy yy 
nnoremap <silent> YY "+Y

nnoremap <silent> . .


"delete
nnoremap <silent> d d
nnoremap <silent> x x
nnoremap <silent> dd dd
nnoremap <silent> dp d$
nnoremap <silent> dw d0

nnoremap <silent> dn dbx

"move window
nnoremap <silent> l <C-w>w

"search
nnoremap <silent> / /
nnoremap <silent> ? ?
nnoremap <silent> c n
nnoremap <silent> C N
"ignoring key

nnoremap <silent> o <Nop>
nnoremap <silent> O <Nop>
nnoremap <silent> H <Nop>
nnoremap <silent> 0 <Nop>
nnoremap <silent> M <Nop>
nnoremap <silent> L <Nop>

nnoremap <silent> <C-d> <Nop>
nnoremap <silent> <C-u> <Nop>
nnoremap <silent> <C-f> <Nop>
nnoremap <silent> <C-b> <Nop>
nnoremap <silent> R <Nop>  "replace 
nnoremap <silent> <C-f> <Nop>
nnoremap <silent> <C-p> <Nop>
nnoremap <silent> S <Nop> 
nnoremap <silent> P <Nop> 
nnoremap <silent> D <Nop> 

" VISUAL MODE
vnoremap <silent> d d
vnoremap <silent> y y
vnoremap <silent> > >  
vnoremap <silent> < < 
vnoremap <silent> = =
vnoremap <silent> gu u
vnoremap <silent> GU U
vnoremap <silent> u p
vnoremap <silent> c c

vnoremap <silent> n b
vnoremap <silent> e w

vnoremap <silent> gr r

vnoremap <silent> r h
vnoremap <silent> s j
vnoremap <silent> f k
vnoremap <silent> t l
vnoremap <silent> w ^
vnoremap <silent> p $

vnoremap <silent> Y "+y

vnoremap <silent> jj <Esc>
" INSERT MODE
inoremap <silent> jj <Esc>

" TERMINAL MODE
tnoremap <silent> jj <C-\><C-n>
nnoremap <silent> jj <Esc>

" Source %
nnoremap <F5> :source %<CR>
