"---------------- CONFIG----------------
" Enable utf8
set encoding=utf-8
" Enable fish shell
set shell=bash

"" Clear screen on exit
"set t_te= t_ti=
"au VimLeave * :!clear

" Visual Block Tab/Untab
" gg=G Re-indents all the the document
" <C-T> Indent (on insert mode)   >> (on visual mode)
" <C-D> Unindent (on insert mode) << (on visual mode)
:vnoremap > >gv
:vnoremap < <gv
" Alternative using Tab/Shift-Tab (for gvim).
:vnoremap <Tab> >gv
:vnoremap <S-Tab> <gv

" Highlighting
syntax on
colorscheme delek

" Status Line (now powerline)
set ls=2
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" show line number at left
set number

" change paste toogle (autoindent when pasting from other apps) => <F2>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" auto indent (http://tedlogan.com/techblog3.html)
set smartindent
set tabstop=4      " number of spaces per tab
set shiftwidth=4   " number of spaces in automatic indentation and <<,>>
set softtabstop=4  " makes the spaces feel like real tabs (backspace deletes the 4 spaces)
set expandtab      " tab writes spaces

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" ctags
set tags=./tags;~/tags
set mouse=a
map <C-g> <C-]>
"autocomplete from ctags
"<C-n>
"<C-p>
highlight Pmenu ctermfg=black ctermbg=white

" cscope (not finished)
filetype on

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" enable menus in console => <F4>
  " solves duplicated entries in menu
  set langmenu=none
if !has("gui_running")
    :source $VIMRUNTIME/menu.vim
    :set wildmenu
    :set cpoptions-=<
    :set wildcharm=<C-Z>
    :map <F4> :emenu <C-Z>
endif

" Show differences with original file => <F9>
function! DiffPreview()
    diffthis | vsplit | enew | set buftype=nofile | read # | 1delete | diffthis
endfunction
map <F9> :call DiffPreview()<CR>

" Crontab files are edited in place
autocmd filetype crontab setlocal nobackup nowritebackup
" Rsnapshot.conf MUST use tab not spaces
autocmd BufRead,BufWrite rsnapshot.conf set noexpandtab

" Show tabs & spaces
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping

" ---------------- Vundle -------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" minufbufexpl not needed after tabline in airline
"Bundle 'minibufexpl.vim'
Bundle 'Syntastic'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
Bundle 'SeeTab'
Bundle 'EasyGrep'
Bundle 'wting/rust.vim'
Bundle 'leafgarland/typescript-vim'
" -- YMC --
Bundle 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0
" -- OmniSharp --
"Bundle 'nosami/Omnisharp'
" -- Markdown --
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1
Bundle 'suan/vim-instant-markdown'
Bundle 'editorconfig/editorconfig-vim'
" -- Rust Autocomplete
Bundle 'phildawes/racer'
set hidden
let g:racer_cmd = "/usr/local/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src/"
" -- Go lang
Bundle 'fatih/vim-go'
" -- TagBar --
Bundle 'majutsushi/tagbar'
" -- Fish Syntax Highlighting --
Bundle 'dag/vim-fish'
" -- Dart Syntax Highlighting --
Bundle 'dart-lang/dart-vim-plugin'
" --
filetype plugin on
filetype plugin indent on
