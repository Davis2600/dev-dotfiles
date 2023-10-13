" Comments in Vimscript start with a `"`.
 
" If you open this file in Vim, it'll be syntax highlighted for you.
 
" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
" Turn on syntax highlighting.
syntax on
set cursorline
autocmd vimenter * ++nested colorscheme gruvbox
" let g:airline_theme='onehalfdark'
set cursorline
filetype on
" Disable the default Vim startup message.
" set shortmess+=I
 
" Show line numbers.
set number
 
" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber
 
" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2
 
" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start
 
" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden
 
" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase
 
" Enable searching as you type, rather than waiting till you press enter.
set incsearch
 
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
 
" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=
 
" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a
 
" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
imap jk <Esc>
" remap omniselect to command space
inoremap <S-TAB> <C-X><C-O>
 
 
" Vim Plugins:w
" jjjj
set runtimepath^=~/.config/nvim/bundle/ctrlp.vim
 
call plug#begin('~/.config/nvim/plugged')
 
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/indentpython.vim'
 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
Plug 'Yggdroot/indentLine'
 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
 
Plug 'sheerun/vim-polyglot'
 
Plug 'airblade/vim-gitgutter'
 
Plug 'tpope/vim-surround'
 
Plug 'vim-airline/vim-airline'
 
Plug 'sonph/onehalf', {'rtp': 'vim'}
 
Plug 'morhetz/gruvbox'
 
Plug 'APZelos/blamer.nvim'
 
call plug#end()
" This will automatically launch the file explorer
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:neoformat_try_formatprg = 1
 
" This is the keyboard shortcut for nerdtree
map <C-n> :NERDTreeToggle<CR>
" Another NerdTree Tweak
" show existsing tab with 4 spaces
set tabstop=2
" wehn indenting with '>', use 4 spaces
set shiftwidth=2
" On pressing tab, do four spaces
set expandtab
set autoindent
 
" set go syntax highlighting
" let g:go_highlight_extra_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_parameters = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_variable_declarations = 1
" set gopls configuration
" let g:go_gopls_enabled = 1
" let g:go_gopls_options = ['-remote=auto']
" let g:go_gopls_analyses = v:null
" let g:go_gopls_complete_unimported = v:true
" let g:go_gopls_deep_completion = v:true
 
 
 
" air-line
let g:airline_powerline_fonts = 1
 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
 
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
 
 
 
function! g:FzfFilesSource()
  let l:base = fnamemodify(expand('%'), ':h:.:S')
  let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'
 
  if base == '.'
    return 'rg --files'
  else
    return printf('rg --files | %s %s', l:proximity_sort_path, expand('%'))
  endif
endfunction
 
 
function! g:FzfGrepSource()
  let l:base = fnamemodify(expand('%'), ':h:.:S')
  let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'
 
  if base == '.'
    return 'rg'
  else
    return printf('rg | %s %s', l:proximity_sort_path, expand('%'))
  endif
endfunction
 
 
noremap <C-p> :call fzf#vim#files('', {
      \ 'source': g:FzfFilesSource(),
      \ 'options': '--tiebreak=index'})<CR>
 
noremap <C-g> :Rg <CR>
 
 
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
 
nmap <C-k> :BlamerToggle <CR>


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
