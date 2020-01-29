" create a new s-expr
noremap! (( ()<left>
inoremap (<cr> (<cr>)<c-o>O

" now if you use the two previous guys, `(` is available to introduce
" mappings so for example
map!     <buffer> (d ((define<space>
map!     <buffer> (m ((map<space>
noremap! <buffer> (n (newline)
map!     <buffer> (l ((λ ((
map!     <buffer> (f ((define ((
vnoremap ' a(oh

" make it compile
set aw mp=guile\ --no-auto-compile\ -s\ %
" TIPS: consider adding a mapping to make. mine is
" inoremap ,x :make<cr>
" TODO: remove all the anoying guile repl header

" first, you need to create a tag file based on
" dpkg -L $( aptitude search '~i ~n guile-2' -F%p ) |
"       perl -lnE 'print if /[.]scm$/ && -f' |
"       ctags -L - -f ~/.vim/ctags/guile
" TODO: make it smarter? providing it ?

set tags+=~/.vim/ctags/guile

" digraphs (:h digraphs) for greek letters are <c-k>*c
" (where c is a for α, b for β, c for ξ, ...) so
noremap! <buffer> *l <c-k>*l
noremap! <buffer> *S <c-k>*S
" now can type `*l` to get the λ symbol (and `*<c-v>l` to get `*l`)


" now fuzzy completion is at work so you just need to write
" the begining of the chunks to " complete.
" fuzzy completion is defined as the 'ofu' (:h 'ofu) and mapped with <tab>
"

set ofu=SchemeFuzzyComplete
inoremap <tab> <c-x><c-o>

" as examples:
"   us-m<tab>    use-modules
"   d-d-h<tab>   declare-date-header!
"   de-di<tab>   debug-disable
"   syn-r<tab>   syntax-rules

fun! SchemeFuzzyComplete (find,b)
    if a:find
        let l:col  = col('.')
        " get the word to complete
        let l:word = matchstr(strpart(getline('.'),0,l:col),'\v\k+\ze\)?$')
        " positiion of the begining of the word
        return l:col - len(l:word) - 1
    else
        let l:match = '^' . substitute(a:b,'-','[^-]*-','g')
        " so the word to complete  | returns a pattern
        " del-fun                  | ^del[^-]*-fun[^-]*-
        " now use this pattern to filter tags on their names
        " returns the list of the names of the tags
        return map(taglist(l:match), 'v:val["name"]')
    endif
endfun
