" ls 
" %: The buffer in current window
" a: Active buffer, loaded and visible
" line *: Cursor is in the line
" h: A hidden buffer, loaded but not displayed
" #: The alternate buffer
" +: unsaved change
" [No Name]: after run `new` command create a new buffer, can use :w filename
" to save it

set autowrite
set clipboard=unnamed
set colorcolumn=80,120
set cursorline
set encoding=utf-8
set expandtab
set foldlevel=99
set foldmethod=indent
set hidden
set nocompatible              " required
"set number
set shiftwidth=2
set showtabline=2
set signcolumn=yes
set softtabstop=2
set tabstop=2
set t_Co=256

filetype off                  " required
let mapleader = ","

" Enable folding with the spacebar
nnoremap <space> za

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'AndrewRadev/splitjoin.vim' " struct split and join
Plugin 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plugin 'dyng/ctrlsf.vim' " Text Searching mimics Ctrl-Shift-F on Sublime Text 2
Plugin 'easymotion/vim-easymotion'
Plugin 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'} " Status Line
Plugin 'preservim/nerdtree' " File folder tree explorer
Plugin 'Yggdroot/indentLine' " Display intention levels
Plugin 'yegappan/grep' " Integrate Grep seach tools
Plugin 'ludovicchabant/vim-gutentags'

"Plugin 'tpope/vim-fugitive' " Git wrapper
"Plugin 'tpope/vim-commentary' " Comment stuff out
"Plugin 'dense-analysis/ale' " Check syntax asynchronously and fix files
"Plugin 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
"Plugin 'godlygeek/tabular'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'rhysd/vim-lsp-ale'
"Plugin 'mattn/vim-lsp-settings'
"Plugin 'prabirshrestha/asyncomplete.vim'
"Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"
" program language
Plugin 'fatih/vim-go' " go
Plugin 'yuezk/vim-js' " Syntax highlighting for javascript and Flow.js
Plugin 'maxmellon/vim-jsx-pretty' " JSX and TSX syntax pretty highlighting
Plugin 'xolox/vim-misc' " lua
Plugin 'xolox/vim-lua-ftplugin' " lua
Plugin 'preservim/vim-markdown' " markdown
Plugin 'nvie/vim-flake8' " Static syntax and style checker for python
Plugin 'ilyachur/cmake4vim' " cmake
" theme
Plugin 'altercation/vim-colors-solarized' " Precision colorscheme
Plugin 'jnurmine/Zenburn' " A low-contrast color scheme
Plugin 'arcticicestudio/nord-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree
let g:NERDTreeFileLines = 1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-Q> :NERDTree<CR>
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open vim-dispatch window and scroll to bottom
nnoremap    <C-m>m    :Copen<CR> <bar> G
" Build debug and release targets
nnoremap    <C-m>bd   :Dispatch! make -C build/Debug<CR>
nnoremap    <C-m>br   :Dispatch! make -C build/Release<CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ autoindent
    \ fileformat=unix

au BufNewFile,BufRead *.jsx,*.js,*.html,*.css,*.json
    \ set tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ textwidth=79
    \ autoindent
    \ fileformat=unix

hi BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highlight_all=1

" color theme -------
syntax enable 
let g:solarized_termcolors=256
set background=dark
if has('gui_running')
  colorscheme solarized
else
  colorscheme nord
endif

call togglebg#map("<F5>")

" golang ------

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]build$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" smart buffer delete
function! SmartBufDelete()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        enew
    endif

    execute("bdelete! ".l:currentBufNum)
endfunction
nnoremap <silent> <Leader>d :call SmartBufDelete()<CR>

" intentLine
"let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0
"let g:indentLine_color_term = 128
" ============================================================================
" Gutentags 配置
" ============================================================================

" 1. 开启 gutentags 模块
let g:gutentags_modules = ['ctags']

" 2. 设定项目根目录的标志（遇到这些文件或文件夹，就认为到了项目根目录）
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 3. 自动生成的 tags 文件名
let g:gutentags_ctags_tagfile = '.tags'

" 4. 【关键】将自动生成的 tags 文件集中存放在一个固定的缓存目录，避免污染源码
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 如果缓存目录不存在，则自动创建
if !isdirectory(g:gutentags_cache_dir)
   call mkdir(g:gutentags_cache_dir, 'p')
endif

" 5. 配置 ctags 的参数
let g:gutentags_ctags_extra_args = [
            \ '--tag-relative=yes',
            \ '--fields=+ailmnS',
            \ '--extra=+q',
            \ '--c++-kinds=+cxzn',
            \ '--c-kinds=+cxzn',
            \ ]

" 6. 排除不需要生成 tags 的大型文件夹或特定文件类型
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'xxd']
let g:gutentags_ctags_exclude = [
            \ '*.git', '*.svg', '*.hg',
            \ '*/tests/*',
            \ 'build',
            \ 'dist',
            \ 'bin',
            \ 'node_modules',
            \ 'bower_components',
            \ 'cache',
            \ 'compiled',
            \ 'docs',
            \ 'bundle',
            \ 'vendor',
            \ '*.md',
            \ '*.json',
            \ '*.js',
            \ ]
