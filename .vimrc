set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" use fuzzy finder in vim
Plugin 'junegunn/fzf.vim'

" status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" git support in vim
Plugin 'tpope/vim-fugitive'
Plugin 'jreybert/vimagit'

" file browser
Plugin 'scrooloose/nerdtree'

" linting engine
Plugin 'dense-analysis/ale'

" code completition
Plugin 'ycm-core/YouCompleteMe'

" go code tools/completion
Plugin 'fatih/vim-go'
Plugin 'sebdah/vim-delve'
Plugin 'Shougo/deoplete.nvim'
Plugin 'deoplete-plugins/deoplete-go', { 'do': 'make'}

" testing
Plugin 'janko/vim-test'
Plugin 'tpope/vim-dispatch'

" Color
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'romainl/Apprentice'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomasr/molokai'
" Tagbar
Plugin 'majutsushi/tagbar'

" Enhancements
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" make fzf work
set rtp+=~/.fzf

syntax enable
set background=dark
colorscheme molokai
set hlsearch
set ignorecase
set nu

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let mapleader=","
nnoremap ; :Files<Cr>
nnoremap <C-n> :Files<Cr>
nnoremap <C-e> :Buffers<Cr>
nnoremap <C-b> :YcmCompleter GoToDefinition<Cr>
nnoremap <C-f> :GGrep<Cr>
" split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set tabstop=2
set shiftwidth=2
set softtabstop=2

" copy/paste
noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>y "+y
noremap <Leader>p "+p

noremap <Leader>t A //TODO 

" doesn't work in gvim :(
nmap <C-_>   <Plug>NERDCommenterToggle

command! SearchWordCursorList :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc
" TODO change this to use <q-args>
command! SearchWordList :execute 'vimgrep '.input('Enter search word: ').' '.expand('%') | :copen | :cc
command! DelTrailingWhitespace :execute '%s/\s\+$//e'
command! InsertCurrentTime :execute 'put =strftime(\"\n%c\")' | :execute 'normal o'
command! Notes :execute 'FZF ~/notes'

noremap <Leader>s :SearchWordList<Cr>
noremap <Leader>sw :SearchWordCursorList<Cr>

nmap <BS> bdw
inoremap <C-BS> <C-w>
inoremap <C-l> <C-Right>
inoremap <C-h> <C-Left>
inoremap <C-b> <C-Left>

" search for word undercursor
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Go specific syntax highlighting
let g:go_highlight_build_constraints = 1
"let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_types = 1
let g:go_auto_sameids = 1


" search as characters are entered, as you type in more characters, the search is refined
set incsearch

" allows vim-test to use quickfix window for test output
let test#strategy = "dispatch"

" make mouse work
set mouse=a

" show trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=#66090c
match ExtraWhitespace /\s\+$/

" fold code automatically
set foldmethod=syntax
set foldlevel=1
" fixes issue where :GoFmt have a :w will close folds
let g:go_fmt_experimental = 1


" show hi group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" color diff background "+" -> green(bold) "-" -> red
hi diffRemoved          guibg=#66090c ctermbg=52
hi diffAdded            guibg=#0d4a15 ctermbg=22 gui=bold cterm=bold

let g:clang_snippets_engine='clang_complete'

set tags=tags

if has("nvim")
	let g:ycm_filetype_blacklist = { 'go': 1 }
	tnoremap <Esc><Esc> <C-\><C-n>
	tnoremap <C-,> <C-\><C-n>
	autocmd TermOpen * setlocal nonumber norelativenumber
endif

" highlight cursorline
set cursorline
let g:syntastic_go_checkers = ['golint', 'errcheck']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" indent bullet list starting with '-' properly
set comments +=fb:-

" put swap files in one directory
set directory^=$HOME/.vim/tmp//

" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)
