""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable compatibility mode
set nocompatible

" Clear all autocmds
autocmd!

" Setup pathogen
execute pathogen#infect()

" Enable highlighting for syntax
syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Insert space characters whenever the tab key is pressed
set expandtab

" Insert 4 spaces for each tab key
set tabstop=4

" Insert 4 spaces for indentation
set shiftwidth=4

" The backspace key treats 4 spaces as a tab
set softtabstop=4

" Copy the indentation from the previous line
set autoindent

" Move cursor to the matching string while typing the search pattern
set incsearch

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" This makes RVM work inside Vim.
set shell=bash

" Don't create backups
set nobackup
set nowritebackup

" If backups are created, put them into following dirs:
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

" Turn folding off
set foldmethod=manual
set nofoldenable

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

aug autoFormat
  " Clear all autocmds in the group. Otherwise they will be created twice if
  " .vimrc is reloaded
  autocmd!

  autocmd FileType text setlocal textwidth=78

  " 2 spaces, expand tabs, auto-indent
  autocmd FileType ruby,markdown,haml,eruby,yaml,html,javascript,cucumber,clojure set ai sw=2 sts=2 et

  " 4 spaces, expand tabs
  autocmd FileType python set sw=4 sts=4 et
aug END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=16
" Use visual bell instead of a sound
set vb

if &term =~ '256color'
  set t_ut=
endif

colorscheme solarized
set background=light

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gVim-specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guifont=Fira\ Mono:h16
  set background=light
else
  set background=dark
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Biggie :Piggieback (cemerick.austin/exec-env :exec-cmds ["open" "-ga" "/Applications/Google Chrome.app"])

