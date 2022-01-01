" vim-plug plugin manager: https://github.com/junegunn/vim-plug

" Directory for vim-plug plugins.
call plug#begin('~/.vim/vim-plug')

Plug 'Chiel92/vim-autoformat'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ron-rs/ron.vim'
Plug 'vim-airline/vim-airline'

" NOTE: need to figure out which of these to keep
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

" NOTE: these plugins don't really seem to do well
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'rust-lang/rust'

call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab

" Leader key is space, nice and convenient.
let mapleader = "\<SPACE>"

" Map Ctrl-lhjk to move between splits.
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Map Shift-jk to move between buffers.
nnoremap K :bnext<CR>
nnoremap J :bprev<CR>

" vim-autoformat
let g:autoformat_verbosemode=0
let g:formatterpath = ["/home/gautier/.cargo/bin/rustfmt"]
nnoremap <F3> :Autoformat<CR>

" deoplete
" let g:deoplete#enable_at_startup = 1

" easymotion
" Use a single leader char to trigger easymotion instead of 2.
map <Leader> <Plug>(easymotion-prefix)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map f <Plug>(easymotion-bd-f2)

" fzf
let g:fzf_layout = {'down': '20%'}
" f like find.
nnoremap <leader>f :FZF<CR>

" LanguageClient
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" FIXME: this overlaps with buffer switch
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" Nerdtree
" t like tree.
nnoremap <leader>t :NERDTreeToggle<CR>

" Solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" vim-airline
" Enable top buffer bar.
let g:airline#extensions#tabline#enabled = 1

" vim-commentary
nnoremap <Leader>c :Commentary<CR>
vnoremap <Leader>c :Commentary<CR>

" vim-lsp: language server
" if executable("rls")
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
"         \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
"         \ 'whitelist': ['rust'],
"         \ })
" endif
