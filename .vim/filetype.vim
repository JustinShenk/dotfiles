if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.py        setfiletype python
    au! BufRead,BufNewFile *.tpp       setfiletype cpp
augroup END
