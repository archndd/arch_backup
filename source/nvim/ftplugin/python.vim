""{{{ Plug
"call plug#begin('~/.config/nvim/plugged')

"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"let g:semshi#excluded_hl_groups = []
"let g:semshi#mark_selected_nodes = 0

"call plug#end()
"" }}}

iabbrev ifname: if __name__ == "__main__":<CR>
setlocal foldmethod=indent
setlocal foldnestmax=3
