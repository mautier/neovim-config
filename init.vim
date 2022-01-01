" vim-plug plugin manager: https://github.com/junegunn/vim-plug

" Directory for vim-plug plugins.
call plug#begin('~/.vim/vim-plug')

" A collection of lua utilities that lots of plugins want.
Plug 'nvim-lua/plenary.nvim'

" Fuzzy search / overlays
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" Syntax highlighting and more
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    " To install a new language parser:
    " :TSInstallInfo
    " :TSInstall <language>
    " Installed languages: python, rust, dockerfile, bash, cpp, markdown, vim, lua
Plug 'ron-rs/ron.vim'
Plug 'vim-autoformat/vim-autoformat'

" Tab- and Status-line
" Go to https://www.nerdfonts.com/font-downloads and use "DejaVuSansMono Nerd Font"
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'  " icons in status line
Plug 'kdheepak/tabline.nvim', {'branch': 'main'}
" Plug 'vim-airline/vim-airline'

" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'EdenEast/nightfox.nvim', {'branch': 'main'}
Plug 'marko-cerovac/material.nvim', {'branch': 'main'}

" Motions
Plug 'phaazon/hop.nvim', {'branch': 'v1'}
" Plug 'easymotion/vim-easymotion'

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

"""""""""""""""" Motions
" Easymotion
    " Use a single leader char to trigger easymotion instead of 2.
    " map <Leader> <Plug>(easymotion-prefix)
    " map <Leader>j <Plug>(easymotion-j)
    " map <Leader>k <Plug>(easymotion-k)
    " map <Leader>w <Plug>(easymotion-w)
    " map <Leader>b <Plug>(easymotion-b)
    " map f <Plug>(easymotion-bd-f2)
" Hop
    lua require'hop'.setup()
    map f <cmd>HopChar2<cr>
    map <Leader>j <cmd>HopLine<cr>
    map <Leader>w <cmd>HopWord<cr>
    map <Leader>/ <cmd>HopPattern<cr>

"""""""""""""""" Telescope
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>

    " fzf
    " let g:fzf_layout = {'down': '20%'}
    " nnoremap <leader>f :FZF<CR>

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

syntax enable

"""""""""""""""" Colorscheme
" Solarized
    " set background=dark
    " let g:solarized_termcolors=256
    " colorscheme solarized

" Material
    " let g:material_style = "deep ocean"
    " colorscheme material
" lua << END
" require('material').setup({
    " borders = true
" })
" END

" Nightfox
    colorscheme nightfox

"""""""""""""""" Tab- and Status-line
" vim-airline
    " Enable top buffer bar.
    " let g:airline#extensions#tabline#enabled = 1

" lualine & tabline:
lua << END
require'lualine'.setup {
    options = {
        theme = "nightfox"
        -- theme = "material-nvim"
    }
}

require'tabline'.setup {
    enable = true,
    options = {
        max_bufferline_percent = 80,
        show_tabs_always = false,
        show_filename_only = false,
    }
}

END

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


" Syntax highlighting for files with strange extensions
autocmd BufNewFile,BufRead *.lalrpop set syntax=rust
