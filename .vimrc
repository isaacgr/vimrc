" install vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' " the color theme
Plug 'vim-airline/vim-airline' " bottom status line
Plug 'airblade/vim-gitgutter' " show the gitdiff in the side column
Plug 'preservim/nerdtree' " file system explorer
Plug 'vim-syntastic/syntastic' " syntax highlighting
Plug 'nvie/vim-flake8' " flake8 syntax and style checker for python
Plug 'davidhalter/jedi-vim' " python autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server
Plug 'hynek/vim-python-pep8-indent'
Plug 'tell-k/vim-autopep8' " python pep8 formatting
Plug 'AndrewRadev/splitjoin.vim' " switch between single line and multiline statment
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " execute commands
Plug 'leafgarland/typescript-vim' " typescript syntax highlighting
Plug 'pangloss/vim-javascript' " javascript syntax highlighting
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'vim-scripts/BufClose.vim'
"Plug 'junegunn/goyo.vim' " distraction free writing
"Plug 'easymotion/vim-easymotion' " simplified vim motions
"Plug 'mileszs/ack.vim' " ack search
"Plug 'vim-scripts/vcscommand.vim' " subversion/cvs file manipulation

call plug#end()

filetype on
syntax on 

if has('gui_running')
    colorscheme evening
endif

let mapleader = ";"

" enable true colors support "
set termguicolors

" dark background
set bg=dark

" Vim colorscheme "
colorscheme gruvbox

set colorcolumn=80
set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
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

" jedi vim
let g:jedi#popup_select_first=1

" Git Gutter
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

" Buffer shortcuts
map <leader>bn :bnext<CR>
map <leader>bp :bprevious<CR>
map <leader>bd :bprevious\|bdelete#<CR>
map <leader>bx :buffer<Space>

" Tab shortcuts
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>td :tabclose<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
map <leader>d :cp<CR>
" go to next quickfix line
map <leader>f :cn<CR>
" pretty-format JSON in current buffer
map <leader>j :%!python -m json.tool<CR>
" recursive grep for symbol under cursor (exact match)
map <leader>g :grep! -r --include=*.py --include=*.h --include=*.c --include=*.cpp --include=*.sh --include=*.pg_dump --include=*.txt --include=*.json --include=*.x --include=*.sql --exclude-dir=site-packages --exclude-dir=build --exclude=pylint.txt --exclude-dir=.mypy_cache '\<<c-r><c-w>\>' .
" recursive grep for symbol under cursor
map <leader>h :grep! -r --include=*.py --include=*.h --include=*.c --include=*.cpp --include=*.sh --include=*.pg_dump --include=*.txt --include=*.json --include=*.x --include=*.sql --exclude-dir=site-packages --exclude-dir=build --exclude=pylint.txt --exclude-dir=.mypy_cache '<c-r><c-w>' .
" Ack for symbol under cursor (exact match)
" map <c-a> <Esc>:Ack! --ignore-dir=site-packages --ignore-dir=build -w '<c-r><c-w>'
" Show/hide NERD Tree
map <C-n> :NERDTreeToggle<CR>

"autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:exec '!./venv/bin/python' shellescape(@%, 1)<CR>

" coc options
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-html', 'coc-jedi', 'coc-pyright']
:nmap <silent> <leader>h :<C-U>call CocAction('doHover')<CR>

" Use <Tab> for trigger completion and navigate to the next completion item
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" TSLint config
autocmd BufRead,BufNewFile *.tsx,*.ts setlocal filetype=typescript

" syntastic options
"let g:syntastic_python_checkers=['flake8', 'mypy']
"let g:syntastic_python_flake8_exec='./venv/bin/python3'
"let g:syntastic_python_flake8_args=['-m', 'flake8']
"
"" mypy only exists for python3
"let g:syntastic_python_mypy_exec='./venv/bin/python3'
"let g:syntastic_python_mypy_args=['-m', 'mypy']
""
""" Display syntastic errors in the status line "
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"
"" requires deb: shellcheck
"let g:syntastic_sh_shellcheckers=['shellcheck']
"let g:syntastic_sh_shellcheck_args=['-x', '-e', 'SC1091']

" autopep8 options
let g:autopep8_hang_closing=1
let g:autopep8_aggressive=2
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

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

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
