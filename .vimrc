" Require Vim ≥8.0 or Neovim
" See https://github.com/simnalamburt/.dotfiles/blob/master/.vimrc

"
" General configs
"
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp949,default,latin1
set shell=/bin/bash " http://stackoverflow.com/a/12231417
set diffopt+=iwhite,vertical
set pastetoggle=<F8>
set scrolloff=3
set switchbuf+=usetab,split
set startofline
set splitbelow
set lazyredraw
set nobackup
set nowritebackup
set nocompatible
set nofoldenable
set noshowmode
set noswapfile
set nowrap
set updatetime=500
set termguicolors

" History
if has('persistent_undo')
  set undofile
  let &undodir = $HOME . '/.vim/undodir'
  silent! call mkdir(&undodir, 'p')
endif

" Indentation
set cindent
set autoindent
set smartindent

" Tab
autocmd FileType make setlocal noexpandtab
set softtabstop=2
set shiftwidth=2
set expandtab
autocmd BufEnter * if &filetype == "make" | setlocal noexpandtab | endif
autocmd BufEnter * if &filetype == "textproto" | setlocal noexpandtab | endif

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch | nohlsearch
set nowrapscan

" Line number column
set number
set cursorline
" 80th column color
set textwidth=100
set formatoptions-=t
set colorcolumn=+1,+2,+3
" Listchars
set list
let &listchars = 'tab:› ,extends:»,precedes:«'
" Pair matching
set matchpairs+=<:>
set showmatch
" Wildmenu
set wildmode=longest,full

" Completion
set hidden
set completeopt=preview,menuone,noinsert,noselect
set shortmess+=c
if has('patch-8.1.1564')
  set signcolumn=number
elseif has('nvim') ? has('nvim-0.2') : 1
  set signcolumn=yes
endif


"
" Key mappings
"
let g:mapleader = ','

" Easy file save without switching IME
cabbrev ㅈ w
cabbrev ㅂ q
cabbrev ㅈㅂ wq

" Easy command-line mode
nnoremap ; :
" Easy home/end
inoremap <C-a> <ESC>I
inoremap <C-e> <End>
nnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-a> ^
vnoremap <C-e> $
" Easy horizontal scrolling
noremap <esc>l 3zl
noremap <esc>h 3zh
noremap <a-l> 3zl
noremap <a-h> 3zh
" Easy delete key
vnoremap <backspace> "_d
" Easy file save
nnoremap <silent> <C-s>      :update<CR>
inoremap <silent> <C-s> <ESC>:update<CR>
vnoremap <silent> <C-s> <ESC>:update<CR>
" Easy indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Easy splitting & resizing
nnoremap <silent> <esc>- :split<CR>
nnoremap <silent> <esc>\ :vertical split<CR>
nnoremap <silent> <esc>h :vertical resize -5<CR>
nnoremap <silent> <esc>j :resize -3<CR>
nnoremap <silent> <esc>k :resize +3<CR>
nnoremap <silent> <esc>l :vertical resize +5<CR>
nnoremap <silent> <a--> :split<CR>
nnoremap <silent> <a-\> :vertical split<CR>
nnoremap <silent> <a-h> :vertical resize -5<CR>
nnoremap <silent> <a-j> :resize -3<CR>
nnoremap <silent> <a-k> :resize +3<CR>
nnoremap <silent> <a-l> :vertical resize +5<CR>
" Tab navigations
nnoremap <esc>t :tabnew<CR>
nnoremap <esc>T :-tabnew<CR>
nnoremap <esc>1 1gt
nnoremap <esc>2 2gt
nnoremap <esc>3 3gt
nnoremap <esc>4 4gt
nnoremap <esc>5 5gt
nnoremap <esc>6 6gt
nnoremap <esc>7 7gt
nnoremap <esc>8 8gt
nnoremap <esc>9 9gt
nnoremap <a-t> :tabnew<CR>
nnoremap <a-T> :-tabnew<CR>
nnoremap <a-1> 1gt
nnoremap <a-2> 2gt
nnoremap <a-3> 3gt
nnoremap <a-4> 4gt
nnoremap <a-5> 5gt
nnoremap <a-6> 6gt
nnoremap <a-7> 7gt
nnoremap <a-8> 8gt
nnoremap <a-9> 9gt

" Easy newline insert
function! s:CustomEnter()
  if &modifiable
    normal! o
  else
    " Exception for quickfix buffer and other unmodifiable buffers.
    " See https://vi.stackexchange.com/a/3129
    execute 'normal! \<CR>'
  endif
endfunction
nnoremap <CR> :call <SID>CustomEnter()<CR>

" Easy drag select
function! s:DragSelectMode()
  if &signcolumn != 'no'
    let s:previous_scl = &signcolumn
    set signcolumn=no
    set nonumber
  else
    let &signcolumn = s:previous_scl
    set number
  endif
endfunction
nnoremap <F9> :call <SID>DragSelectMode()<CR>

"
" Install vim-plug if not found
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
"
" List of plugins
"
let s:use_coc = (has('nvim') ? has('nvim-0.3.2') : has('patch-8.0.1453')) && executable('yarn')
try
  call plug#begin('~/.vim/plugged')

  " Configs
  Plug 'tpope/vim-sensible'
  Plug 'vim-utils/vim-interruptless'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  echo s:use_coc


  " Visual
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'ayu-theme/ayu-vim'
  Plug 'junegunn/seoul256.vim'

  " Syntax
  let g:polyglot_disabled = ['v'] | Plug 'sheerun/vim-polyglot'
  Plug 'hashivim/vim-terraform'
  Plug 'wfxr/protobuf.vim'

  " Format
  Plug 'editorconfig/editorconfig-vim'

  " Black (Python formatter)
  " Plug 'psf/black', { 'branch': 'stable', 'do': 'yarn install --frozen-lockfile'}

  " Blink
  Plug 'farmergreg/vim-lastplace'
  Plug 'rhysd/clever-f.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'

  " Util
  Plug 'simnalamburt/vim-mundo'
  Plug 'godlygeek/tabular'
  Plug 'justinmk/vim-dirvish'

  " Translate
  Plug 'uga-rosa/translate.nvim'

  " Git
  Plug 'ryanoasis/vim-devicons'
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-fugitive'

  " Python semantic ide
  Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

  " marp-vim
  Plug 'dhruvasagar/vim-marp'

  " treesitter.vim
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  " telescope.vim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'BurntSushi/ripgrep'

  " IDE
  "if s:use_coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-stylelint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile', 'rtp': 'packages/emoji'}
  Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
  if executable('clangd')
    Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
  endif
  Plug 'jackguo380/vim-lsp-cxx-highlight', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neovim/nvim-lspconfig', {'do': 'yarn install --frozen-lockfile'}
  Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'ervandew/supertab'
  Plug 'cespare/vim-toml'
  Plug 'rust-lang/rust.vim'
  "endif
  if has('nvim-0.6')
    Plug 'github/copilot.vim'
    let g:copilot_filetypes = {
      \ '*': v:true,
      \ 'cplusplus': v:false,
      \ 'c': v:false,
      \ 'python3': v:false,
      \ 'rust': v:false,
    \ }
    " <C-j/k>: to navigate completion menu.
    " <C-j> also opens completion menu.
    inoremap <silent><expr><C-j>
      \ coc#pum#visible() ? coc#pum#next(1) : coc#refresh()
    inoremap <silent><expr><C-k>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
    inoremap <silent><expr><C-l>
      \ coc#pum#visible() ? coc#pum#scroll(1) : "\<C-l>"
    inoremap <silent><expr><C-h>
      \ coc#pum#visible() ? coc#pum#scroll(0) : "\<C-h>"

    let g:copilot_no_tab_map = v:true
    inoremap <silent><expr><tab>
      \ coc#pum#visible() && coc#pum#info()['inserted'] ? coc#pum#confirm() :
      \ coc#pum#visible() && copilot#GetDisplayedSuggestion()['text'] ==# '' ? coc#pum#confirm() :
      \ copilot#Accept("\<Tab>")
    inoremap <silent><expr><Esc>
      \ coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#cancel() : "\<Esc>"

  endif
  call plug#end()

  "
  " Python black config
  "
  "let g:black_linelength = 120

  " Apply black on save
  " augroup black_on_save
  "   autocmd!
  "   autocmd BufWritePre *.py Black
  " augroup end


  "
  " Configs for plugins
  "
  if s:use_coc
    " coc.nvim
    let g:coc_disable_startup_warning = 1

    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocActionAsync('doHover')
      endif
    endfunction

    " hovering
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " coc-highlight
    augroup vimrc_highlight
      autocmd!
      autocmd CursorHold * silent call <SID>highlight()
    augroup END
    function! s:highlight()
      if exists('*CocActionAsync')
        call CocActionAsync('highlight')
      endif
    endfunction

    " coc-yank
    nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<CR>

    " coc-prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

    " supertab
    " let g:SuperTabDefaultCompletionType = "<c-n>"

    " fzf
    nnoremap <F5> :call <SID>lsp_menu()<CR>
    function! s:lsp_menu()
      call fzf#run({
      \ 'source': [
      \   'rename',
      \   'jumpDefinition',
      \   'jumpDeclaration',
      \   'jumpImplementation',
      \   'jumpTypeDefinition',
      \   'jumpReferences',
      \   'diagnosticInfo',
      \   'diagnosticNext',
      \   'diagnosticPrevious',
      \   'format',
      \   'openLink',
      \   'doQuickfix',
      \   'doHover',
      \   'refactor',
      \ ],
      \ 'sink': function('CocActionAsync'),
      \ 'options': '+m',
      \ 'down': 10 })
    endfunction
  endif

  " nerdtree
  noremap <silent> <C-n> :NERDTreeToggle<CR>
  function! s:nerdtree_startup()
    if exists('s:std_in') || argc() != 1 || !isdirectory(argv()[0])
      return
    endif
    execute 'NERDTree' argv()[0]
    wincmd p
    enew
    execute 'cd '.argv()[0]
    NERDTreeFocus
  endfunction
  augroup vimrc_nerdtree
    autocmd!

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * call s:nerdtree_startup()
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  augroup END

  " vim-indent-guides
  nmap <leader>i <Plug>IndentGuidesToggle
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_default_mapping = 0

  " vim-terraform
  let g:terraform_fmt_on_save=1

  " clever-f.vim
  let g:clever_f_across_no_line = 1
  let g:clever_f_smart_case = 1

  " incsearch.vim
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " incsearch-easymotion.vim
  function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    \   'keymap': {
    \     "\<tab>": '<Over>(easymotion)'
    \   },
    \   'is_expr': 0
    \ }), get(a:, 1, {}))
  endfunction
  noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
  noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
  noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

  " translate.vim
  nnoremap <space>tj viw:Translate JP<CR>

  " mundo.vim
  let g:mundo_right = 1
  nnoremap <leader>g :MundoToggle<CR>
catch /^Vim\%((\a\+)\)\=:E117/
endtry


"
" My vim theme
"
let ayucolor = 'dark'
try
  colorscheme ayu
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme elflord
endtry

function! s:fg(item, color)
  execute printf('highlight %s guifg=%s', a:item, a:color)
endfunction
function! s:bg(item, color)
  execute printf('highlight %s guibg=%s', a:item, a:color)
endfunction

" TabLine
let s:tab_color = '#1c2328'
highlight TabLine cterm=NONE gui=NONE
call s:fg('TabLine', '#62788c')
call s:bg('TabLine', s:tab_color)
call s:fg('TabLineSel', '#FFFFFF')
call s:bg('TabLineSel', s:tab_color)
call s:fg('TabLineFill', s:tab_color)

" Pretty vimdiff colorscheme
call s:fg('DiffDelete', '#232b32')
call s:bg('DiffDelete', 'NONE')

" IndentGuides
let s:indent_color = '#151a1e'
call s:bg('IndentGuidesEven', s:indent_color)
call s:bg('IndentGuidesOdd', s:indent_color)

" Matching
let s:match_color = '#232b32'
highlight MatchParen cterm=NONE gui=NONE
call s:bg('MatchParen', s:match_color)
call s:bg('CocHighlightText', s:match_color)

" scroll coc docs
" set mouse=a

" Python rootPatterns
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']



"
" Define a 'vimrc' augroup
"
augroup vimrc
  autocmd!

  " Vim automatic reload
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None
augroup END


"
" Local configs
"
if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif
