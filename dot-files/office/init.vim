call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot' "plugin for highlighting
Plug 'arcticicestudio/nord-vim' "nord color scheme 
" Plug 'tpope/vim-fugitive' 
Plug 'neoclide/coc.nvim', {'branch': 'release'} "plugin for autocompletion
Plug 'itchyny/lightline.vim', {'colorscheme': 'nord'} "plugin for status bar
Plug 'preservim/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'habamax/vim-godot'
" Plug 'preservim/nerdcommenter'
Plug 'tomtom/tcomment_vim' " plugin for commenting/uncommenting 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " installs fzf for a fuzzy file search
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color' " preview css colors
Plug 'mg979/vim-visual-multi', {'branch': 'master'} "Adds multiple cursors sublime style
" Plug 'dense-analysis/ale'
" Plug 'jiangmiao/auto-pairs' " inserts or delete matching brackets, quotes, etc.
" Plug 'prettier/vim-prettier', { 'do': 'npm install' } " adds auto formating for Javascript
"
call plug#end()

" let g:godot_executable = '~/Applications/custom-godot-bin/godot.x11.opt.tools.64'
let g:godot_executable = '/home/glalev/.local/bin/godot-official-spine' 

let g:coc_global_extensions = [
      \'coc-tsserver',
      \'coc-json',
      \'coc-css',
      \'coc-html',
      \'coc-pairs',
      \'coc-prettier',
      \]

" sets the colorscheme of the status bar and ands the git branch
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" auto refresh NerdTree when a new file is  created
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
     \ quit | endif

" adds a command that searches within the whole project but ignores node_modules, modules, locales, and .git folders
command! -bang -nargs=* Rgp call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -g "!{.git/*,node_modules/*}" '.shellescape(<q-args>), 1,  fzf#vim#with_preview(), <bang>0)

" adds Vb command to start Visual-Block mode
command! Vb normal! <C-v>

" adds command for auto formating using Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" setlocal foldmethod=expr
" setlocal tabstop=4
" SHORT KEYS ===========================================
" nnoremap <buffer> <F4> :GodotRunLast<CR>
" nnoremap <buffer> <F5> :GodotRun<CR>
" nnoremap <buffer> <F6> :GodotRunCurrent<CR>
" nnoremap <buffer> <F7> :GodotRunFZF<CR>
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" alt + j moves the cursor down in 'Insert' mode
inoremap <M-j> <Down>
" alt + k moves the cursor up in 'Insert' mode
inoremap <M-k> <Up>
" alt + k moves the cursor up in 'Insert' mode
inoremap <M-h> <Left>
" alt + h moves the cursor left in 'Insert' mode
inoremap <M-l> <Right>
" alt + i escepes the 'Insert' mode back to 'Normal' mode
inoremap <M-i> <Esc>
" alt + v escepes the 'Visual' mde back to 'Normal' mode
xnoremap <M-v> <Esc>
" toggles NERDTree when f4 is pressed
nnoremap <F4> :NERDTreeToggle<CR>
" comment/uncomment a line on ctrl + /
noremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>
" saves the file on ctrl + s
noremap <C-s> :w<CR>

" used to change sub-window on focus
":noremap <Tab> <C-w>

" to paste to the global clipboard in only in normal mode
nnoremap <C-v> "+p
" ctrl + x to cut to to global clipboard
" noremap <C-x> "+x
" ctrl + c to copy to the global clipboard
noremap <C-c> "+y 
" does a fuzzy file search within the whole project
noremap <Leader>f :Files<CR>
" shows all active buffers
noremap <Leader>b :Buffers<CR>
" shows all active windows
noremap <Leader>w :Windows<CR>
" does a fuzzy search within the whole project
noremap <Leader>r :Rgp<CR>
" autoformats the code
noremap <Leader>p :Prettier<CR>

"adds or removes the coloring of the 81 column, basically acts as a vertical line indicating the 80th symbol
noremap <Leader>h :set colorcolumn=81<CR>
noremap <Leader>H :set colorcolumn=0<CR>

" removes all highlighting if such
noremap <Leader><Space> :noh<CR>
" toggles the spellcheck
noremap <Leader>s :set spell!<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
noremap <Leader>d :CocDiagnostics<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" SHORT KEYS END ========================================
 
set mouse=a
set encoding=UTF-8
set number "adds number lines;

" when the screen is scrolled to the next screen 5 lines from the previous screen are kept
set scrolloff=3

" used for case insensitive seach when the search is only lower case
set ignorecase
set smartcase

" allows opening of new buffer or window when the current buffer is not saved
set hidden

" The folliwing two are from coc.nvim example config
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

colorscheme nord " sets the global colorschemeo

set completeopt=menu,menuone,noselect
