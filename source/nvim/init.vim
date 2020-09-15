" {{{ Plugin
call plug#begin('~/.config/nvim/plugged')

""""" COLORSCHEME
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
let g:onedark_terminal_italics=1

""""" Mosly for PROPRAMMING
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'

""""" MARKDOWN
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" tabular goes with vim markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_previewer = 'okular'
 
""""" UTILITY
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/suda.vim'
Plug 'benmills/vimux'
let g:VimuxPromptString="> "
let g:VimuxOrientation = "h"
let g:VimuxHeight = "28"
Plug 'christoomey/vim-tmux-navigator'
"
call plug#end()
" }}}
" {{{ NERDTree
nnoremap <A-e> :NERDTreeToggle<CR>
"}}}
" {{{ Coc
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}}
" {{{ Colorscheme
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark 
let g:lightline = {'colorscheme': 'onedark'}
set background=dark
set t_Co=256

" FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Todo', 'yoffset': 0.2, 'border': 'sharp' } }
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
" }}}
" {{{ Indent
set autoindent
set expandtab
set shiftwidth=4 tabstop=4
set shiftround
set smarttab
" }}}
" {{{ Searching
set hlsearch
set inccommand=nosplit
set incsearch
set ignorecase
set smartcase
" }}}
" {{{ Text displaying 
syntax on
set linebreak " Prevent Vim wrap a line in the middle of a word
set showbreak=...
set scrolloff=6 sidescrolloff=5
set wrap
set showmatch matchtime=3 " Show matching bracket
" toggle invisible characters
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
nnoremap <silent> <F12> :set list!<CR>
" }}}
" {{{ User interface
set laststatus=2 " Always show status line
set foldcolumn=0
set ruler
set wildmenu wildmode=longest:full,full wildoptions=tagfile
set cursorline
set number relativenumber
" set lazyredraw " Don't redraw while excuting macros

set noerrorbells novisualbell
set confirm " Show saving menu when quitting without saving
set showcmd cmdheight=1
set splitright splitbelow
" }}}
" {{{ Folding 
" Folding by triple-{ in vim and bash file
augroup filetype_vim
    autocmd!
    autocmd FileType vim,sh setlocal foldmethod=marker formatoptions-=cro
augroup END 
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldnestmax=3
augroup END
" }}}
" Spell check {{{
function! Turn_spell()
    if &l:spell
        echo "Turning off spell check"
        setlocal spell!
    else
        echo "Turning on spell check"
        setlocal spell!
    endif
endfunction

augroup set_spell
    autocmd!
    autocmd FileType text,markdown :setlocal spell spelllang=en_us
augroup END
nnoremap <silent> <F10> :call Turn_spell()<CR>
" }}}
" {{{ Other
set backspace=indent,eol,start " Allow backspace to go through indent, end of line, start of line 
set backupdir=$HOME/.config/nvim/cache
set directory=$HOME/.config/nvim/tmp
set history=1000
set clipboard+=unnamedplus
set encoding=utf8
set autoread " Detect when file is changed
set timeoutlen=500
set wildignore=*.swp,*.o,*~,*.pyc " Ignore compile file
set nocompatible 
filetype plugin on
" }}}
if has('mouse')
    set mouse=a " Allow to use mouse
endif
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

autocmd FileType python iabbrev ifname: if __name__ == "__main__":
" {{{ English Contractions
let g:contractions = [["arent", "aren't"], ["cant", "can't"], ["couldnt", "couldn't"], ["couldve", "could've"], ["didnt", "didn't"], ["doesnt", "doesn't"], ["dont", "don't"], ["hadnt", "hadn't"], ["hasnt", "hasn't"], ["havent", "haven't"], ["hed", "he'd"], ["hes", "he's"], ["Im", "I'm"], ["Ive", "I've"], ["isnt", "isn't"], ["itd", "it'd"],  ["itll", "it'll"], ["mightnt", "mightn't"], ["mightve", "might've"], ["mustnt", "mustn't"], ["mustve", "must've"], ["neednt", "needn't"], ["oughtnt", "oughtn't"], ["shes", "she's"], ["shouldnt", "shouldn't"], ["shouldve", "should've"], ["thatd", "that'd"], ["thats", "that's"], ["thered", "there'd"], ["therell", "there'll"], ["theres", "there's"], ["theyd", "they'd"], ["theyll", "they'll"], ["theyre", "they're"], ["theyve", "they've"], ["wasnt", "wasn't"], ["weve", "we've"], ["werent", "weren't"], ["wont", "won't"], ["wouldnt", "wouldn't"], ["wouldve", "would've"], ["youd", "you'd"], ["youll", "you'll"], ["youre", "you're"], ["youve", "you've"]]
" }}}
" {{{ General mapping 
let mapleader = " " " Set leader to <space>
noremap " " <nop>

" Fast saving
nnoremap <leader>w :w<CR>
" Close current buffer
nnoremap <leader>q :bd<CR>
" Sudo save
command! W execute 'w suda://%' <bar> edit!
command! E execute 'e suda://%' <bar> edit!

" Turn off hightlight 
noremap <silent> <leader>j :noh<CR>

" Paste on new line (For system clipboard)
nnoremap <leader>p o<ESC>p
nnoremap <leader>P O<ESC>p

" Move between windows 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" TODO make resize mapping vertically and horizontally
" Resize window
nnoremap <A--> :vertical res -5<CR>
nnoremap <A-=> :vertical res +5<CR>
nnoremap <A-[> :res +3<CR>
nnoremap <A-]> :res -3<CR>

" Enter normal using jk 
inoremap jk <ESC>
" ; for : instead
noremap ; :
noremap : ;

nnoremap Y y$

" Text navigate
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> H g^
noremap <silent> L g$
noremap <silent> <A-j> 7j
noremap <silent> <A-k> 7k
noremap <silent> <A-h> 5h
noremap <silent> <A-l> 5l

" Add a line in normal mode
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>

" " Find the word that the cursor is in
" noremap <leader>F #
" noremap <leader>f *

" Folding
nnoremap <leader>a za
nnoremap <leader>sa zm

" init.vim editing 
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>:noh<CR>
autocmd BufNewFile,BufReadPre init.vim nnoremap <silent> <leader>w :w<CR>:source $MYVIMRC<CR>

" Keep visual selection when indenting
vnoremap > >gv
vnoremap < <gv

" Spell check
nnoremap <leader>= z=

" Swap song name and artist
vnoremap <leader>sw :s/\(.*\) - \(.*\)/\2 - \1<CR>:noh<CR>$

" FZF
nnoremap <A-r> :Rg<CR>
nnoremap <leader>F :FZF<CR>
nnoremap <leader>f :Files<CR>

" {{{ Vimux
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vi :VimuxInspectRunner<CR>
nnoremap <leader>vl :w<CR>:VimuxRunLastCommand<CR>
" }}}
" }}}
" Markdown {{{
function! Del_sharp()
    if getline('.')[col('.')-1] == "#"
        normal df 
    endif
endfunction

function! Markdown_setting()
    " Markdown conceal bold and italic
    setlocal conceallevel=3
    setlocal comments=
    " {{{ Bold
    nnoremap <buffer> <silent> <leader>ub ciw****<ESC>hhp
    " Bold inside WORD
    nnoremap <buffer> <silent> <leader>uB ciW****<ESC>hhp
    " Bold selection text
    vnoremap <buffer> <silent> <leader>ub <ESC>`>a**<ESC>`<i**<ESC>
    " Delete bold text
    nnoremap <buffer> <silent> <leader>dub m0?*<CR>h2x/*<CR>2x:noh<CR>`02h
    " }}}
    " {{{ Italic
    " Italic inside word
    nnoremap <buffer> <silent> <leader>ui ciw__<ESC>hp
    " Italic inside WORD
    nnoremap <buffer> <silent> <leader>uI ciW__<ESC>hp
    " Italic selection text
    vnoremap <buffer> <silent> <leader>ui <ESC>`>a_<ESC>`<i_<ESC>
    " Delete italic text
    nnoremap <buffer> <silent> <leader>dui m0?_<CR>x/_<CR>x:noh<CR>`0h
    "}}}
    " {{{ Switch bold and italic
    " Convert bold to italic
    nnoremap <buffer> <silent> <leader>uri m0?*<CR>hxs_<ESC>/*<CR>xs_<ESC>:noh<CR>`0h
    " Convert italic to bold
    nnoremap <buffer> <silent> <leader>urb m0?_<CR>s**<ESC>/_<CR>s**<ESC>:noh<CR>`0l
    " }}}
    " {{{ Heading
    " Add the heading
    nnoremap <buffer> <silent> <leader>h1 0:call Del_sharp()<CR>i#<space><ESC>$
    nnoremap <buffer> <silent> <leader>h2 0:call Del_sharp()<CR>i##<space><ESC>$
    nnoremap <buffer> <silent> <leader>h3 0:call Del_sharp()<CR>i###<space><ESC>$
    nnoremap <buffer> <silent> <leader>h4 0:call Del_sharp()<CR>i####<space><ESC>$
    nnoremap <buffer> <silent> <leader>h5 0:call Del_sharp()<CR>i#####<space><ESC>$
    nnoremap <buffer> <silent> <leader>h6 0:call Del_sharp()<CR>i######<space><ESC>$

    " Delete the heading
    nnoremap <buffer> <silent> <leader>dh 0df<space>
    vnoremap <buffer> <silent> <leader>dh :s/^#*<space>/<CR>:noh<CR>
    " }}}
    " {{{ List
    vnoremap <buffer> <silent> <leader>ul :s/^/*<space><CR>:noh<CR>
    nnoremap <buffer> <silent> <leader>ul ^i*<space><ESC>
    " }}}
    for pair in g:contractions
        execute "iabbrev <buffer> ". pair[0]. " ". pair[1]
    endfor
endfunction

augroup markdown_setting
    autocmd FileType vimwiki :set filetype=markdown
    autocmd FileType markdown :call Markdown_setting()
augroup END
"}}}

