" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" file manager
Plugin 'scrooloose/nerdtree' " nerdtree file browser
Plugin 'kien/ctrlp.vim'      " ctrlp

" complete
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab' " SuperTab

" UI
Plugin 'bling/vim-airline'                " airline & its themes
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized' " colorscheme
Plugin 'nlknguyen/papercolor-theme'
Plugin 'nathanaelkane/vim-indent-guides'  " show the indent

" Editor general
Plugin 'easymotion/vim-easymotion'       " easymotion & easy-align
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'        " comment
Plugin 'majutsushi/tagbar'               " Tag
Plugin 'bronson/vim-trailing-whitespace' " cut white
Plugin 'terryma/vim-multiple-cursors'    " multi cursor select
Plugin 'jiangmiao/auto-pairs'            " auto pairs

" markdown enchance
Plugin 'plasticboy/vim-markdown'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Search
Plugin 'mileszs/ack.vim' " need to install ag

" python
" need to install
Plugin 'davidhalter/jedi-vim'

" verilog
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'antoinemadec/vim-verilog-instance'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" file {
    "set color
    syntax enable
    set nobackup
    set smartindent

    " file encoding
    set encoding=utf-8
    set fileencodings=utf-8,chinese,latin-1
" }



" UI {
    " set language

    if has('gui_running')
        "hide the menu and tool bar
        set guioptions-=T
        set guioptions-=m
        set guioptions-=r
        set guioptions-=L
    endif

    " set cursor
    set cursorline
    set cursorcolumn
    set scrolloff=3  " minimum lines to keep above the cursor
    set mouse=a      " automatically enable mouse usage
    set mousehide    " hide the mouse cursor while typing
    " set gcr=a:block-blinkon0 " set cursur flash in windows gcr = guicursor

    if has('gui_running')
        "set the init window size
        set lines=40 columns=123
    endif

    " set font
    set guifont=Consolas\ for\ Powerline\ FixedD:h12

    " set indent
    set ts=4 sw=4 et " et = expandtab
    set ai si " ai = autoindent si = smartindent
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1

    "set line number
    set nu! relativenumber

    "close the beep
    set vb

    " colorsheme
    set background=dark
    colorscheme PaperColor "solarized

    " set the airline alway show!
    set laststatus=2
    set ttimeoutlen=10 " set the leave time frome insert(make it more quick)
    " airline setting {
        let g:airline_theme = 'powerlineish'
        let g:airline_section_z = airline#section#create(['%3p%%', ':%2v'])
        let g:airline_section_error = {}
        let g:airline_section_warning= {}
    " }

    " search
    set incsearch " increase search
    set hlsearch  " highlight search
    set ignorecase " case insensitive search

    " window split default
    " set splitright " always split to left
    set splitbelow
"}


" key-binding {

    " set leader
    let mapleader=';'

    " open a nerdtree when start
    nmap <silent> <F2> :NERDTreeToggle<CR>

    " ctags
    nmap <silent> <F7> :!ctags -R .<CR>

    " Tagbar
    nmap <silent> <F8> :TagbarToggle<CR>

    " set short-key
    noremap j gj
    noremap k gk
    noremap b 0
    noremap e $
    noremap <C-m> %
    vnoremap // y/<C-R>"<CR>

    " file
    nnoremap <silent> <leader>fr :CtrlPMRUFiles<CR>
    nnoremap <silent> <leader>ff :CtrlP<CR>
    nnoremap <silent> <leader>fe :e ~/.vimrc<CR>
    nnoremap <silent> <leader>fs :w<CR>

    " buffer
    nnoremap <silent> <leader>bb :CtrlPBuffer<CR>
    nnoremap <silent> <leader>bd :bd<CR>
    nnoremap <silent> <leader>bn :bn<CR>
    nnoremap <silent> <leader>bp :bp<CR>

    " window
    " = to adjust the views to same size
    nnoremap <silent> <leader>w  <C-w>
    nnoremap <silent> <leader>wd <C-w>q
    nnoremap <silent> <Leader>wz :ZoomToggle<CR>

    " Git
    nnoremap <silent> <Leader>gs :Gstatus<CR>
    nnoremap <silent> <Leader>gc :Gcommit<CR>
    nnoremap <silent> <Leader>gl :Glog<CR>
    nnoremap <silent> <Leader>gd :Gdiff<CR>

    " visual shifting
    vnoremap < <gv
    vnoremap > >gv

    " Whitefix
    nnoremap <Leader>xw :FixWhitespace<CR>

    vmap <Enter> <Plug>(EasyAlign)

    " easymotion {
        let g:EasyMotion_do_mapping = 0 " Disable default mappings

        " `s{char}{char}{label}`
        " Need one more keystroke, but on average, it may be more comfortable.
        nmap s <Plug>(easymotion-overwin-f2)

        " Turn on case insensitive feature
        let g:EasyMotion_smartcase = 1

        " JK motions: Line motions
        map <Leader>jk <Plug>(easymotion-overwin-line)

        " Search
        map / <Plug>(easymotion-sn)
        " map n <Plug>(easymotion-next)
        " map N <Plug>(easymotion-prev)

    " }
" }

" Plugin setting {
    " ycm
    " let g:ycm_server_python_interpreter  = 'c:/Python35/python.exe'

    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

    " better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }

" Search {
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
" }

" verilog {
    " verilog setting
" }

" EasyAlign {
    let g:easy_align_delimiters = {
    \ 'd': {
    \     'pattern'        : ' \ze\S\+\s*[=;]',
    \     'left_margin'    : 0     ,
    \     'right_margin'   : 0     ,
    \     'delimiter_align': 'r'
    \    }
    \ }
" }
