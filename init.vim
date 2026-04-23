call plug#begin('~/.local/share/nvim/plugged')

Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'honza/vim-snippets'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

call plug#end()
" =============== telescope ===============
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git/"},
  }
}
EOF
lua << EOF
require('telescope').load_extension('fzf')
EOF

let mapleader=" "

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" ================= GLOBAL =================
syntax on
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set hidden
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set signcolumn=yes
set cmdheight=2
set updatetime=300
set encoding=utf-8
set nobackup
set nowritebackup
set splitright
set splitbelow
set autoread
set mouse=a
filetype on
filetype plugin on
filetype indent on

" ================= THEME =================
if exists('+termguicolors')
  set termguicolors
endif

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_current_word = 'bold'
colorscheme sonokai

if has("nvim")
  highlight Normal guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
endif

let g:airline_theme = 'sonokai'

" ================= PYTHON VENV =================
let g:python3_host_prog = expand("~/.config/nvim/venv/bin/python")

" ================= ALE =================
let g:ale_linters = {}
let g:ale_fixers = { '*': ['trim_whitespace'] }
let g:ale_fix_on_save = 1

" ================= NERDTREE =================
nmap <C-a> :NERDTreeToggle<CR>

" ================= AIRLINE =================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ================= COC =================
let g:coc_global_extensions = ['coc-snippets','coc-explorer']

" -------- TAB INTELIGENTE (FIX PRINCIPAL) --------
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Shift+Tab navega no menu
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter confirma autocomplete
inoremap <silent><expr> <CR>
  \ coc#pum#visible() ? coc#pum#confirm()
  \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Trigger manual
inoremap <silent><expr> <c-space> coc#refresh()

" ================= NAVEGAÇÃO =================
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ================= DOC =================
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" ================= ACTIONS =================
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>qf  <Plug>(coc-fix-current)

" ================= STATUS =================
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ================= LISTAS =================
nnoremap <silent> <space>a  :CocList diagnostics<CR>
nnoremap <C-e> :CocCommand explorer<CR>

" ================= SNIPPETS =================
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" ================= COC EXPLORER =================
nnoremap <space>e :CocCommand explorer<CR>


" =============== remaps =========================
" Create a tab
nmap te :tabe<CR>
" Navigate between buffers
nmap ty :bn<CR>
nmap tr :bp<CR>