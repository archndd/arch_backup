" java.vim - Java refactor
" Author:       Duy
" Version:      1.0

function! s:Construct()
    " Copy fields to e
    exe "norm! \"eyi{"
    " Copy class name to c
    exe "norm! ?class\<cr>w\"cyiw"
    " Empty constructor
    exe "norm! /}\<cr>O\<esc>opublic \<esc>\"cpa(){\<cr>}\<esc>"
    " Copy empty constructor to u and past
    exe "norm! Vk\"uyjo\<esc>\"up"
    " Create parameter for constructor
    exe "norm! \"epvi{:s/\\(\\s*\\)\\a\\{-} \\=\\(\\w\\+\\) \\(\\w\\+\\);\\s*\\n/\\2 \\3, \<cr>"
    " Copy parameter to t
    exe "norm! $F,xi\<cr>\<esc>k^v$h\"tddd"
    " Paste parameter
    exe "norm! k^f(\"tp"
    " Assign this.a = a 
    exe "norm! \"epvi{>vi{:GetField\<cr>"
    " GetterSetter
    exe "norm! jo\<esc>\"ep`[v`]:GetterSetter\<cr>dd"
endfunction 

function! s:GetField() range
    execute a:firstline. ','. a:lastline. 's/\(\s*\)\a\{-} \=\(\w\+\) \(\w\+\);/\1this.\3 = \3;'
endfunction

function! ConstructorFull() range
    execute
endfunction

function! s:GetterSetter() range
    " Refactor the field define into setter
    " public String string;
    " String string;
    
    " public String setString(){
    "     return this.string;
    " }
    "
    " public void setString(String string){
    "   this.string = string;
    " }
    
    " \1 is for the indent
    " \2 is type
    " \3 is var name 
    
    execute a:firstline. ','. a:lastline. 's/\(\s*\)\a\{-} \=\(\w\+\) \(\w\+\);/\1public void set\u\3(\2 \3){\r\1\tthis.\3 = \3;\r\1}\r\r\1public \2 get\u\3(){\r\1\treturn this.\3;\r\1}\r'
endfunction

command! -range GetterSetter <line1>,<line2>call <SID>GetterSetter()
command! -range GetField <line1>,<line2>call <SID>GetField()
command! -range Constructor <line1>,<line2>call <SID>Constructor()
command! Construct call <SID>Construct()
