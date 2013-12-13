
if exists('g:loaded_syntastic_nesc_nescc_checker')
    finish
endif
let g:loaded_syntastic_nesc_nescc_checker = 1

if !exists('g:syntastic_nc_compiler')
    let g:syntastic_nc_compiler = 'nescc'
endif

function! SyntaxCheckers_nesc_nescc_IsAvailable()
    return executable(g:syntastic_nc_compiler)
endfunction


function! SyntaxCheckers_nesc_nescc_GetLocList()
    let errorformat =
        \ '%-G%f:%s:,' .
        \ '%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,' .
        \ '%-G%f:%l: %#error: %#for each function it appears%.%#,' .
        \ '%-GIn file included%.%#,' .
        \ '%-G %#from %f:%l\,,' .
        \ '%f:%l:%c: %trror: %m,' .
        \ '%f:%l:%c: %tarning: %m,' .
        \ '%f:%l:%c: %m,' .
        \ '%f:%l: %trror: %m,' .
        \ '%f:%l: %tarning: %m,'.
        \ '%f:%l: %m'


    let makeprg = syntastic#makeprg#build({
        \ 'exe': g:syntastic_nc_compiler,
        \ 'args': ' -fsyntax-only ',
        \ 'filetype': 'nesc',
        \ 'subchecker': g:syntastic_nc_compiler })


    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat})

endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'nesc',
    \ 'name': 'nescc'})


" vim: set et sts=4 sw=4:
