set number "adds number lines;

call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot' "plugin for highlighting
Plug 'arcticicestudio/nord-vim' "nord color scheme 
Plug 'tpope/vim-fugitive' 
Plug 'neoclide/coc.nvim', {'branch': 'release'} "plugin for autocompletion
Plug 'itchyny/lightline.vim', {'colorscheme': 'nord'} "plugin for status bar
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'

call plug#end()

" sets the colorscheme of the status bar and ands the git branch
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" SHORT KEYS ===========================================

" alt + j moves the cursor down in 'Insert' mode
:inoremap <M-j> <Down>
" alt + k moves the cursor up in 'Insert' mode
:inoremap <M-k> <Up>
" alt + k moves the cursor up in 'Insert' mode
:inoremap <M-h> <Left>
" alt + h moves the cursor left in 'Insert' mode
:inoremap <M-l> <Right>
" alt + i escepes the 'Insert' mode back to 'Normal' mode
:inoremap <M-i> <Esc>
" alt + v escepes the 'Visual' mode back to 'Normal' mode
:xnoremap <M-v> <Esc>
" toggles NERDTree when f4 is pressed
:nnoremap <F4> :NERDTreeToggle<CR>
" comment/uncomment a line on ctrl + /
:noremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>
" saves the file on ctrl + s
:noremap <C-s> :w<CR>

" used to change sub-window on focus
:noremap <Tab> <C-w>
" copy to the global clipboard
:noremap <S-y> "+y
" cut to to global clipboard
:noremap <S-x> "+x
" cut to the global clipboard
:noremap <S-p> "+p

" SHORT KEYS END ========================================
 
:set mouse=a
:set encoding=UTF-8

colorscheme nord " sets the global colorscheme
