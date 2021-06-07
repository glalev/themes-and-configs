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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " installes fzf for a fuzzy file search
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs' " inserts or delete matching brackets, quotes, etc.
Plug 'prettier/vim-prettier', { 'do': 'npm install' } " adds auto formating for Javascript

call plug#end()

let g:coc_global_extensions = [ 'coc-tsserver' ]

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

" auto refresh NerdTree when a new file is  created
autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

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

" to paste to the global clipboard in only in normal mode
:nnoremap <C-v> "+p
" ctrl + x to cut to to global clipboard
:noremap <C-x> "+x
" ctrl + c to copy to the global clipboard
:noremap <C-c> "+y 
" does a fuzzy file search within the whole project
:noremap <Leader>f :Files<CR>
" shows all active buffers
:noremap <Leader>b :Buffers<CR>
" does a fuzzy search within the whole project
:noremap <Leader>r :Rg<CR>
" autoformats the code
:noremap <Leader>p :Prettier<CR>
" GoTo code navigation.
:nmap <silent> gd <Plug>(coc-definition)
:nmap <silent> gy <Plug>(coc-type-definition)
:nmap <silent> gi <Plug>(coc-implementation)
:nmap <silent> gr <Plug>(coc-references)
" SHORT KEYS END ========================================
 
:set mouse=a
:set encoding=UTF-8

colorscheme nord " sets the global colorscheme
