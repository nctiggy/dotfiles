filetype off
execute pathogen#infect()
set nocompatible
filetype plugin indent on
syntax on
let mapleader=","
set mouse=a
set nowrap
colorscheme dracula
let &winheight = &lines * 10 / 10

" Don't go back to beginning of file when scanning/search
set nowrapscan

" Toggle wrap
nmap <leader>sw :set wrap!<CR>

inoremap <C-y> <esc>gUiw`]a

" Press '' quickly in insert mode instead of Esc
imap '' <Esc>

" Treat all numerals as decimal even if zero padded
set nrformats=

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Easier split movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Don't lose what's in the register after paste
xnoremap p pgvy

" More natural split opening
set splitbelow
set splitright

" Hide buffers instead of closing them
set hidden

" Show line numbers
set number

" vim-javascript settings
let g:javascript_plugin_flow = 1

" Highlight search terms
set hlsearch

" Show search matches as you type
set incsearch

" Don't use old ways of protecting against data loss
set nobackup
set noswapfile

set pastetoggle=<leader>p


" Set indentation preferences
"   ts='number of spaces that <Tab> in file uses'
"   sts='number of spaces that <Tab> uses while editing'
"   sw='number of spaces to use for (auto)indent step'
" for details see: vimdoc.sourceforge.net/htmldoc/quickref.html#option-list
set expandtab
set ts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype sh setlocal ts=4 sts=4 sw=4
autocmd Filetype gitconfig setlocal ts=4 sts=4 sw=4

" Show column rulers
set colorcolumn=72,80


" Show whitespace
set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<

" Customize syntastic plugin
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 1
"let g:syntastic_python_flake8_args='--ignore=E402'

" NERDTree settings
" map <C-n> :NERDTreeToggle<CR>
nmap <leader>nt :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$','^\.DS_Store$']
" match the keyboard bindings of CtrlP
autocmd FileType nerdtree nmap <buffer> <C-v> s
autocmd FileType nerdtree nmap <buffer> <C-x> i

" Might as well set the built in Explorer too
let g:netrw_liststyle=3


" Remove trailing whitespace for certain filetypes
fun! <SID>StripTrailingWhitespaces()
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType ansible,c,cpp,java,php,ruby,python,sh,vim autocmd BufWritePre
        \ <buffer> :call <SID>StripTrailingWhitespaces()


" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>


" Setting for ctrlp plugin
let g:ctrlp_map='<c-p>'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode=''
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set wildignore+=.DS_Store
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set wildignore+=tags

let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'coverage':  '\v(htmlcov|\.?coverage)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Integrate ctrlp with ctags
nnoremap <leader>. :CtrlPTag<cr>


" Set up ag.vim
" Always start searching from the project root dir
let g:ag_working_path_mode="r"
nmap <leader>ag :Ag<SPACE>""<Left>

" Override grep to use Ag instead

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K yiw:Ag<SPACE><C-R>0<CR>

" Set up tagbar
nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" Setup test.vim
" nmap <silent> <leader>s :TestNearest<CR>
" nmap <silent> <leader>t :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>
" let test#strategy = "tslime"

" Determine the python test runner to use
if filereadable(".pytest")
    let test#python#runner = 'pytest'
elseif filereadable(".djangotest")
    let test#python#runner = 'djangotest'
elseif isdirectory("./lib/ansible")
    let test#python#runner = 'nose'
elseif isdirectory("../../../ansible")
    let test#python#runner = 'nose'
elseif isdirectory("./libcloud")
    let test#runners = {'Python': ['LibCloudTest']}
    let test#python#runner = 'libcloudtest'
endif

" Pytest options
let test#python#pytest#options = {
    \ 'nearest': '--capture=no -v',
    \ 'file': '--capture=no --random',
    \ 'suite': '--capture=no --random',
    \}
" Nose options
let test#python#nose#options = {
    \ 'nearest': '-v -s',
    \ 'file': '-s --randomize',
    \ 'suite': '-s --randomize',
    \}

" Execute current file
nnoremap <Leader>r :!%:p

" YouCompleteMe plugin
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0
" To customize g:ycm_path_to_python_interpreter, put it in your
" ~/.vimrc.local instead

" Lightline plugin
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ }
" Always show the status line
set laststatus=2
" We don't need the extra vim mode info now that lightline is in use
set noshowmode

au BufRead,BufNewFile *.yaml.tpl set ft=yaml
au BufRead,BufNewFile gitconfig set ft=gitconfig

" ALWAYS DO THIS LAST
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
