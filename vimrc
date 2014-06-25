"---------------- CONFIG----------------
" Clear screen on exit
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
set expandtab     " tab writes spaces

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

" ---------------- Vundle -------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'minibufexpl.vim'
Bundle 'Syntastic'
Bundle 'SeeTab'
Bundle 'EasyGrep'
Bundle 'wting/rust.vim'
Bundle 'leafgarland/typescript-vim'
" -- YMC --
Bundle 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0
" -- OmniSharp --
"Bundle 'nosami/Omnisharp'

filetype plugin indent on
