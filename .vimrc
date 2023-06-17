" install vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/BufClose.vim'
Plug 'nvie/vim-flake8'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/vcscommand.vim'
" Plug 'tmhedberg/SimpylFold'
" Plug 'Konfekt/FastFold'
Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tell-k/vim-autopep8'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Quramy/tsuquyomi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype on
syntax on 

if has('gui_running')
    colorscheme evening
endif

" enable true colors support "
set termguicolors

" dark background
set bg=dark

" Vim colorscheme "
colorscheme gruvbox

set colorcolumn=80
set gfn=Bitstream\ Vera\ Sans\ Mono\ 12
set updatetime=2000
set nocompatible
set nowrap
set history=50
set hlsearch
set ruler
set backspace=indent,eol,start
set hid
set incsearch
set guioptions-=T
set wildmode=longest,list,full
set wildmenu
set showcmd
set formatoptions=ro
set makeprg=make
set scrolloff=10
set number
" options related to indent
set expandtab
set cindent
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Always show the status line at the bottom, even if you only have one window
" open.
set laststatus=2
" By default, vim's python.vim indents 2 * shiftwidth() when adding a new line
" after the opening of parenthesis. I don't know why it does that, but I hate
" it. Indent by shiftwidth() instead.
let g:pyindent_open_paren = shiftwidth()

:command Bc BufClose

" set block style cursor in gVim " 
set guicursor=n-v-c:block-nCursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

" set block style cursor in WSL "
if &term =~? 'rxvt' || &term =~? 'xterm' || &term =~? 'st-'
    " 1 or 0 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
    " Insert Mode
    let &t_SI .= "\<Esc>[6 q"
    " Normal Mode
    let &t_EI .= "\<Esc>[2 q"
endif

" Git Gutter
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

" Map Ctrl+j to move the cursor to the window below "
" Map Ctrl+k to move the cursor to the window above "
" Map Ctrl+h to move the cursor to the window left "
" Map Ctrl+l to move the cursor to the window right "
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Copy selected text to buffer "
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>

" Paste text from buffer
map <C-p> :r ~/.vimbuffer<CR>

" open the quickfix window
map <F12> :copen<CR>
" close the quickfix window
map <C-F12> :cclose<CR>
" exit diff mode
map <F9> :set noscrollbind nodiff<CR>
" go to previous quickfix line
map <S-d> :cp<CR>
" go to next quickfix line
map <S-f> :cn<CR>
" pretty-format JSON in current buffer
map <C-q> :%!python -m json.tool<CR>
" recursive grep for symbol under cursor (exact match)
map <c-g> <Esc>:grep! -r --include=*.py --include=*.h --include=*.c --include=*.cpp --include=*.sh --include=*.pg_dump --include=*.txt --include=*.json --include=*.x --include=*.sql --exclude-dir=site-packages --exclude-dir=build --exclude=pylint.txt --exclude-dir=.mypy_cache '\<<c-r><c-w>\>' .
" recursive grep for symbol under cursor
map <c-h> <Esc>:grep! -r --include=*.py --include=*.h --include=*.c --include=*.cpp --include=*.sh --include=*.pg_dump --include=*.txt --include=*.json --include=*.x --include=*.sql --exclude-dir=site-packages --exclude-dir=build --exclude=pylint.txt --exclude-dir=.mypy_cache '<c-r><c-w>' .
" Ack for symbol under cursor (exact match)
" map <c-a> <Esc>:Ack! --ignore-dir=site-packages --ignore-dir=build -w '<c-r><c-w>'
" Show/hide NERD Tree
map <C-n> :NERDTreeToggle<CR>

" syntastic options
let g:syntastic_python_checkers=['flake8', 'mypy']
let g:syntastic_python_flake8_exec='./venv/bin/python'
let g:syntastic_python_flake8_args=['-m', 'flake8']

" TSLint config
autocmd BufRead,BufNewFile *.tsx,*.ts setlocal filetype=typescript

" mypy only exists for python3
let g:syntastic_python_mypy_exec='./venv/bin/python'
let g:syntastic_python_mypy_args=['-m', 'mypy']

" Display syntastic errors in the status line "
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" requires deb: shellcheck
let g:syntastic_sh_shellcheckers=['shellcheck']
let g:syntastic_sh_shellcheck_args=['-x', '-e', 'SC1091']

" autopep8 options
let g:autopep8_hang_closing=1
let g:autopep8_aggressive=2
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

" Prettier options
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType javascript setlocal formatprg=prettier\ --parser\ javascript

" splitjoin
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_trailing_comma = 1

" vim airline buffer tabs "
let g:airline#extensions#tabline#enabled = 1

" vim airline filename formatter "
let g:airline#extensions#tabline#formatter = 'jsformatter'

" show hidden files in nerdtree "
let NERDTreeShowHidden=1

" SimpylFold options
" let g:SimpylFold_fold_import = 0
" let g:SimpylFold_fold_docstring = 0

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

