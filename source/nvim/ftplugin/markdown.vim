" {{{ English Contractions
let g:contractions = [["arent", "aren't"], ["cant", "can't"], ["couldnt", "couldn't"], ["couldve", "could've"], ["didnt", "didn't"], ["doesnt", "doesn't"], ["dont", "don't"], ["hadnt", "hadn't"], ["hasnt", "hasn't"], ["havent", "haven't"], ["hed", "he'd"], ["hes", "he's"], ["Im", "I'm"], ["Ive", "I've"], ["isnt", "isn't"], ["itd", "it'd"],  ["itll", "it'll"], ["mightnt", "mightn't"], ["mightve", "might've"], ["mustnt", "mustn't"], ["mustve", "must've"], ["neednt", "needn't"], ["oughtnt", "oughtn't"], ["shes", "she's"], ["shouldnt", "shouldn't"], ["shouldve", "should've"], ["thatd", "that'd"], ["thats", "that's"], ["thered", "there'd"], ["therell", "there'll"], ["theres", "there's"], ["theyd", "they'd"], ["theyll", "they'll"], ["theyre", "they're"], ["theyve", "they've"], ["wasnt", "wasn't"], ["weve", "we've"], ["werent", "weren't"], ["wont", "won't"], ["wouldnt", "wouldn't"], ["wouldve", "would've"], ["youd", "you'd"], ["youll", "you'll"], ["youre", "you're"], ["youve", "you've"]]
" }}}

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

