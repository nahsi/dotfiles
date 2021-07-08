"
"            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" ----------------------------------------------------------------------------
" {{{ General
" ----------------------------------------------------------------------------
" enable 24 bit colors in tui
set termguicolors

" async
set updatetime=300

" command line completion
set wildmenu

" completion settings
set completeopt=menu,menuone,preview,noinsert

" better navigation
set ignorecase smartcase infercase
set scrolloff=3

" proper backspace behavior
set backspace=indent,eol,start

" formating
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent smartindent smarttab expandtab

" no backup/swap/undo
set nobackup noswapfile undofile

" yank to system clipboard
set clipboard^=unnamed

" enable folding
set foldenable
set foldmethod=marker

" autowrite when using GoBuild and such
set autowrite

" hide messages when autocompleting
set shortmess+=c
"}}}

" {{{ Keybindings
" ----------------------------------------------------------------------------
let mapleader=","

" quickfix window navigation
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``

" Swithing between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" {{{ Presentation
" ----------------------------------------------------------------------------
set colorcolumn=79
set laststatus=2
set cursorline cursorcolumn

" no search hl until next search
nohlsearch

" hidden characters
set list
" pretty tabs (two trailing whitespaces here are required, don't remove)
set listchars=tab:\»\  
" highlight trailing whitespaces
set listchars+=trail:·

" line number
set number relativenumber

" wrap words
set linebreak
" physical column when 'wrap' is off
set listchars+=extends:›,precedes:‹

" hide duplicate mod indicator
set noshowmode

" colorscheme
let base16colorspace=256
colorscheme base16-tomorrow-night
"}}}

" {{{ Plugins
" ----------------------------------------------------------------------------
" autoinstall minpac
if empty(glob(substitute(&packpath, ",.*", "/pack/plugins/opt/minpac", "")))
    call system("git clone --depth=1 https://github.com/k-takata/minpac.git ".substitute(&packpath, ",.*", "/pack/plugins/opt/minpac", ""))
endif

packadd minpac
call minpac#init()

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Tim Pope stuff
call minpac#add("tpope/vim-commentary")
call minpac#add("tpope/vim-surround")
"call minpac#add("tpope/vim-unimpaired")
" git
"call minpac#add("tpope/vim-fugitive")
" better netrw
call minpac#add("tpope/vim-vinegar")

" fzf
call minpac#add("junegunn/fzf.vim")
call minpac#add("airblade/vim-rooter")

" visuals
call minpac#add("chriskempson/base16-vim")
call minpac#add("itchyny/lightline.vim")
call minpac#add("mike-hearn/base16-vim-lightline")
call minpac#add("Yggdroot/indentLine")
call minpac#add("rrethy/vim-hexokinase", { "do": "make hexokinase" })

" vimwiki
call minpac#add("https://github.com/vimwiki/vimwiki")
call minpac#add("https://github.com/tools-life/taskwiki")

" syntax
call minpac#add("https://github.com/jvirtanen/vim-hcl")

" misc
"call minpac#add("mhinz/vim-startify")
" }}}

" {{{ Plugin settings
" ----------------------------------------------------------------------------
" fzf
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>m :Marks<CR>

" preview window up
let g:fzf_preview_window = ["up"]

" customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vimwiki
let g:vimwiki_list = [{'path': '~/.local/vimwiki'}]

" hexokinase
let g:Hexokinase_highlighters = ['foreground']

" lightline
let g:lightline = {
    \ 'colorscheme': 'base16_tomorrow_night',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
  \ }

" indentLine
let g:indentLine_color_term = 237
let g:indentLine_char = '│'
" }}}

" {{{ IDE
" ----------------------------------------------------------------------------
" float-preview
let g:floag_preview#docked=1
" }}}

" {{{ Autocommands
" ----------------------------------------------------------------------------
augroup kernel
    au!
    au FileType kernel.config runtime kernel.vim
augroup END

augroup narrow
    au!
    au Filetype yaml,hcl,ruby,tf,lua,json set tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" pretty bash folding
augroup autofolding
    au!
    au FileType sh
                \ let g:sh_fold_enabled=7 |
                \ let g:is_bash=1 |
                \ set foldmethod=syntax |
                \ syntax enable
augroup END

augroup help
    au!
    au Filetype help set nocursorcolumn colorcolumn=
augroup END

" {{{ general
augroup general
    au!
    " Highlight current line only on focused window
    au WinEnter,InsertLeave * set cursorline
    au WinLeave,InsertEnter * set nocursorline

    " Automatically set read-only for files being edited elsewhere
    au SwapExists * nested let v:swapchoice = 'o'

    " Check if file changed when its window is focus, more eager than 'autoread'
    au WinEnter,FocusGained * checktime

    " Update filetype on save if empty
    au BufWritePost * nested
                \ if &l:filetype ==# '' || exists('b:ftdetect')
                \ |   unlet! b:ftdetect
                \ |   filetype detect
                \ | endif

    " Reload Vim script automatically if setlocal autoread
    au BufWritePost,FileWritePost *.vim nested
                \ if &l:autoread > 0 | source <afile> |
                \   echo 'source '.bufname('%') |
                \ endif

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    au BufReadPost *
                \ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
                \|   execute 'normal! g`"zvzz'
                \| endif

    au FileType gitcommit setlocal spell

    au FileType gitcommit,qfreplace setlocal nofoldenable

augroup END
"}}}
"}}}

" {{{ Other
" ----------------------------------------------------------------------------
" Ingore files vim doesn't use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*
" }}}
" ----------------------------------------------------------------------------
" END
