set number "adds number lines;

call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot' "plugin for highlighting
Plug 'arcticicestudio/nord-vim' "nord color scheme 
Plug 'tpope/vim-fugitive' " plugin to call arbitrary git command /after :Git or just :G/
Plug 'neoclide/coc.nvim', {'branch': 'release'} "plugin for autocompletion
Plug 'itchyny/lightline.vim', {'colorscheme': 'nord'} "plugin for status bar
Plug 'preservim/nerdtree' " Adds file explorer in a separate tab
Plug 'ryanoasis/vim-devicons' " Adds icons to the NERDTree
Plug 'preservim/nerdcommenter' " plugin for commenting/uncommenting whole lines of code when
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " installes fzf for a fuzzy file search
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs' " inserts or delete matching brackets, quotes, etc.
Plug 'prettier/vim-prettier', { 'do': 'npm install' } " adds auto formating for Javascript

call plug#end()

let g:coc_global_extensions = [ 'coc-tsserver' ]

" sets the colorscheme of the status bar and ands the git branch
let g:lightline = {
      \ 'colorscheme': 'wombat',
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

" adds a command that searches within the whole project but ignores node_modules, modules, locales, and .git folders
command! -bang -nargs=* Rgp call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -g "!{.git/*,node_modules/*,modules/*,locales/*}" '.shellescape(<q-args>), 1,  fzf#vim#with_preview(), <bang>0)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" SHORT KEYS ===========================================

" NOTE: because MacOS is the lamest OS in history <C-...> which normally is the ctrl key here is alt and for some
" reason command and opition keys cannot be used
" alt + j moves the cursor down in 'Insert' mode
:inoremap <C-j> <Down>
" alt + k moves the cursor up in 'Insert' mode
:inoremap <C-k> <Up>

" alt + h move the cursor left in 'Insert' mode, NOTE that the auto-pairs plug may overwrite this
:inoremap <C-H> <Left>
" alt + l moves the cursor right in 'Insert' mode
:inoremap <C-l> <Right>
" alt + i escepes the 'Insert' mode back to 'Normal' mode
":inoremap <C-i> <Esc>
" alt + v escepes the 'Visual' mode back to 'Normal' mode
:xnoremap <C-v> <Esc>
" toggles NERDTree when f4 is pressed
:nnoremap <F4> :NERDTreeToggle<CR>
" comment/uncomment a line on ctrl + /
:noremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>
" saves the file on ctrl + s
:noremap <C-s> :w<CR>

" used to change sub-window on focus
:noremap <Tab> <C-w>
" copy to the global clipboard
:noremap <C-y> "+y
" cut to to global clipboard
:noremap <C-x> "+x
" paste to the global clipboard
:noremap <C-p> "+p
" search for a file in the project/sub directories/
:noremap <Leader>f :Files<CR>
" shows all the active buffers
:noremap <Leader>b :Buffers<CR>
" search for a string in the project/while ignoring node_modules, .git, modules and locales folders
:noremap <Leader>r :Rgp<CR>
" autoformats to code
:noremap <Leader>p :Prettier<CR>

"adds or removes the coloring of the 81 column, basically acts as a vertical line indicating the 80th symbol
:noremap <Leader>h :set colorcolumn=81<CR>
:noremap <Leader>H :set colorcolumn=0<CR>

:nmap <silent> gd <Plug>(coc-definition)
:nmap <silent> gy <Plug>(coc-type-definition)
:nmap <silent> gi <Plug>(coc-implementation)
:nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
:noremap <Leader>d :CocDiagnostics<CR>
:nmap <silent> [g <Plug>(coc-diagnostic-prev)
:nmap <silent> ]g <Plug>(coc-diagnostic-next)
" SHORT KEYS END ========================================
 
:set mouse=a
:set encoding=UTF-8

colorscheme nord " sets the global colorscheme
