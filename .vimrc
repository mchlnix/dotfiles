set nocompatible              " be iMproved, required
filetype off                  " required

set hlsearch
set foldmethod=syntax
set laststatus=2              " always show statusline
set noshowmode                " hides Insert from Command Line
set syntax=on

autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" set noswapfile
set number
set scrolloff=100
set tabstop=4
set expandtab
set smartindent

" set the runtime path to include Vundle and initialize
if isdirectory(glob("~/.vim/bundle/Vundle.vim/"))
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        " alternatively, pass a path where Vundle should install plugins
        "call vundle#begin('~/some/path/here')

        " let Vundle manage Vundle, required
        Plugin 'gmarik/Vundle.vim'

        " The following are examples of different formats supported.
        " Keep Plugin commands between vundle#begin/end.
        " plugin on GitHub repo

        Plugin 'plasticboy/vim-markdown'
        Plugin 'davidhalter/jedi-vim'
        Plugin 'flazz/vim-colorschemes'
        Plugin 'smancill/conky-syntax.vim'
        Plugin 'jeroenbourgois/vim-actionscript'
        Plugin 'vim-airline/vim-airline'
        Plugin 'majutsushi/tagbar'
        Plugin 'mgedmin/chelper.vim'

        " All of your Plugins must be added before the following line
        call vundle#end()            " required

        filetype plugin indent on    " required
        " To ignore plugin indent changes, instead use:
        "filetype plugin on
        "
        " Brief help
        " :PluginList          - list configured plugins
        " :PluginInstall(!)    - install (update) plugins
        " :PluginSearch(!) foo - search (or refresh cache first) for foo
        " :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
        "
        " see :h vundle for more details or wiki for FAQ
        " Put your non-Plugin stuff after this line
        "
        let g:jedi#popup_select_first = "0"
        let g:airline#extensions#tagbar#enabled = 1
endif
