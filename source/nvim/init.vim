" {{{ Plugin
call plug#begin('~/.config/nvim/plugged')

""""" COLORSCHEME
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'

""""" Mosly for PROPRAMMING
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'

""""" MARKDOWN
" tabular goes with vim markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
let g:livepreview_previewer = 'okular'
 
""""" UTILITY
" Syntax highlight
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
let g:semshi#excluded_hl_groups = []
let g:semshi#mark_selected_nodes = 0
Plug 'uiiaoo/java-syntax.vim'
Plug 'tpope/vim-classpath'
highlight link javaIdentifier NONE
" Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/suda.vim'
" Tmux stuff
Plug 'benmills/vimux'
let g:VimuxPromptString="> "
let g:VimuxOrientation = "h"
let g:VimuxHeight = "28"
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
" }}}
" {{{ C++
" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}}}
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
set termguicolors
set t_Co=256
colorscheme material
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
let g:lightline = { 'colorscheme': 'material_vim' }

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
augroup scm_indent
    autocmd!
    autocmd BufNewFile,BufRead *.scm setlocal shiftwidth=2 tabstop=2
augroup END

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
set showbreak=→
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
" {{{ Other
set backspace=indent,eol,start " Allow backspace to go through indent, end of line, start of line 
set backupdir=$HOME/.config/nvim/cache
set directory=$HOME/.config/nvim/tmp
set history=1000
set clipboard+=unnamedplus
set encoding=UTF-8
set autoread " Detect when file is changed
set timeoutlen=500
set wildignore=*.swp,*.o,*~,*.pyc " Ignore compile file
set nocompatible 
filetype plugin on
" }}}
if has('mouse')
    set mouse=a " Allow to use mouse
endif

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

" Capitalize each word
vnoremap <leader>su gugv:s/\<./\u&/g<CR>:noh<CR>$

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

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

autocmd BufNewFile,BufRead *.s,*.asm :set filetype=asm
