command! -bang -nargs=* GoFindTests call gofindtests#Jump(<q-args>)
command! -bang -nargs=* GoCoveringTests call gofindtests#List(<q-args>)
