execute pathogen#infect('plugins/{}')
syntax on
filetype plugin indent on
set incsearch
if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

