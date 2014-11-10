" .vimrc
" Author: Nils H. Busch  <nh.busch@web.de>
"
" Environment--------------------------------------------------------------{{{

" Defaults {{{
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" }}}

" OS specifics {{{
if has('win32') || has('win64')      " FIXME: really check if path is on share
  let s:appdata=$LOCALAPPDATA . '/vim/'
  " Set runtime to local folder as $HOME might be on slow network share
  set rtp=$USERPROFILE/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$USERPROFILE/vim/after

  " Add local path for viminfo
  set viminfo+=n$LOCALAPPDATA/vim/_viminfo
  if !isdirectory(expand(s:appdata))
    if exists("*mkdir")
      silent! call mkdir(expand(s:appdata),"p")
    endif
  endif
else
  let appdata='~/.vim/'
endif

" }}}

" Plugin management {{{
filetype off                            " required
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
"execute pathogen#helptags()

if has('autocmd')
  filetype plugin indent on             " required
endif

" Pathogen modifies runtimepath, so turn of capturing options
set sessionoptions-=options

" }}}

" }}}

" Options -----------------------------------------------------------------{{{

" General {{{
if has('syntax') && !exists('g:syntax_on')
  syntax enable                         " syntax highlighting
endif

if &history < 1000                      " max number of commands to remember
  set history=1000
endif

set autoread                            " detect file changes outside of Vim
set autowrite                           " force buffer write
set timeout                             " time out on mapping after 1,2s
set timeoutlen=1200                     
set ttimeout                            " time out on key codes after 100 ms
set ttimeoutlen=100                     

set fileformats+=mac
" }}}

" Backup {{{
set backup                              " turn on backups
"set noswapfile                         " FIXME?

if has('persistent_undo')
  set undofile                          " turn on undo
  set undolevels=1000                   " max number of undos
  set undoreload=10000                  " max #lines for undo on buffer reload
endif

let &backupdir=(s:appdata . 'backup//') " backups
let &directory=(s:appdata . 'swap//')   " swap files
let &undodir=(s:appdata . 'undo//')     " undo files

" Create those folders if they don't exist
if !isdirectory(expand(&undodir)) && exists("*mkdir")
  silent! call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir)) && exists("*mkdir")
  silent! call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory)) && exists("*mkdir")
  silent! call mkdir(expand(&directory), "p")
endif

" }}}

" Completion {{{

" }}}

" Formatting {{{
set autoindent
" }}}

" Whitespace {{{

" }}}

" }}}

" File types --------------------------------------------------------------{{{

" C/CPP {{{

" }}}

" Python {{{

" }}}

" Haskell {{{

" }}}

" Vimscript {{{

" }}}

" CMake {{{

" }}}

" Powershell {{{

"}}}

" Git {{{

" }}}

" Markdown {{{

" }}}

" }}}

" Mappings ----------------------------------------------------------------{{{
let mapleader=","                       " change leader to more convenient ','
let maplocalleader="\\"                 " FIXME: better key?

" toggle (i)nvisible characters
nnoremap <leader>i :set list!<CR> 
" toggle line (n)umbers
nnoremap <leader>n :set number!<CR>

" (re)format line
nnoremap ql ^vg_gq

" more convenient mapping of ESC
inoremap jk <ESC>

"Abbreviations {{{

" }}}

" Mode completion {{{

" }}}

" Shortcuts {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" }}}

" Navigation --------------------------------------------------------------{{{

" Move {{{
set backspace=indent,eol,start
set smarttab                            " sw at start of line, sts elsewehere
" move to last change, similar to gi
nnoremap gI `.                          
" }}}

" Cursorline {{{
augroup cline                   " only show in current window and normal mode
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END
" }}}

" Filetype switching {{{

" }}}

" Folding {{{
" recursively open top fold independent of cursor position
nnoremap z0 zCz0                        
                                        
" }}}

" Highlight {{{
set hlsearch                    " enable highlight search
if maparg('<C-L>', 'n') ==# ''  " use <C-L> to clear highlighting
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" }}}

" Reopen {{{

augroup line_return               " Restore cursor when file is reopened
  au!
  au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   execute 'normal! g`"zvzz' |
      \ endif
augroup END

"}}}

" Search {{{
set incsearch                   " enable incremental search
" }}}

" Selection {{{
" select content of current line w/o indent 
nnoremap vv ^vg_                
" }}}

" Wildmenu {{{

" }}}

" Window {{{
" kill window
nnoremap K :q<CR>                       
" FIXME: conflicts with prior setting to clear highlight; use A modifier;
" but this maps to Menu on Win in gVim
"noremap <C-h> <C-w>h
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l
" }}}

" }}}

" Text objects ------------------------------------------------------------{{{

" Modelines {{{

" }}}

" FIXME: this section after plugin SnippetMate plugin?
" Snippets {{{

" }}}

" }}}

" Plugin settings ---------------------------------------------------------{{{

" }}}

" Plugins -----------------------------------------------------------------{{{

" Matchit {{{
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}

" }}}

" Commands & Functions ----------------------------------------------------{{{

" }}}

" Visual ------------------------------------------------------------------{{{

" General {{{
if !&scrolloff                          " scroll to show at least one line
  set scrolloff=1                       " above and below cursor
endif
if !&sidescrolloff                      " scroll to show at least 5 chars
  set sidescrolloff=5                   " left and right of cursor
endif

set display+=lastline                   " show as much of last line as possible

if &listchars ==# 'eol:$'               " list characters to show
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set ruler
set showcmd

set number                              " show line numbers
set relativenumber                      " show line numbers relative to current

if &tabpagemax < 50                     " max number of tabs
  set tabpagemax=50
endif
" }}}

" Vim UI {{{
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

au VimResized * :wincmd =       " resize split if window is resized
" }}}

" Status line {{{
set laststatus=2                        " always show status line
" }}}

" gVIM {{{
if has('gui_running')
  if has('win32') || has('win64')
    set guifont=Consolas:h11        " switch to default fixed font on Win
  elseif has('unix')
    set guifont=Menlo \Regular:h12
  endif
  colorscheme molokai           " FIXME: try out others: ir-black, solarized

  set guioptions-=T             " remove toolbar
  set guioptions-=t             " disable tearoff menues
  set lines=50 columns=100      " enlarge to 50 lines of text and 100 chars
  if &diff                      " for diff, enlarge to 80 columns per buffer
    let &columns=160 + 2*&foldcolumns + 1
  endif
  if &encoding ==# 'latin1'
    set encoding=utf-8          " force to utf-8
  endif
else
  " set term=builtin_ansi       " make arrow keys and others work
  set mouse=a                   " turn on mouse
endif

" }}}

" }}}

" vim:set ft=vim fmr={{{,}}} fdl=0 fdm=marker tw=78 et sw=2:
