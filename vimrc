execute pathogen#infect('plugins/{}')
syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab
" <CTL-l> redraws the screen and removes and search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Load local vimrc
if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

