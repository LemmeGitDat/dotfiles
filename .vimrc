:filetype indent on

set tabstop=8 softtabstop=0 expandtab shiftwidth=3 smarttab

:set foldmethod=marker

au BufNewFile *.vhd 0r ~/.vim/template.vhd | let IndentStyle = "vhd"
"find the last signal and mark it with 's'
au BufNewFile,BufRead *.vhd :normal G?signalmsgg

:color desert

iab slv std_logic_vector(
iab sl std_logic
iab sig signal
iab var variable

execute pathogen#infect()
syntax on
filetype plugin indent on

"set colorcolumn=110                                                                                           
"highlight ColorColumn ctermbg=darkgray

function! Sm1()
   r~/.vim/sm1.vhd
   normal G
endfunction

function! Sm2()
   r~/.vim/sm2.vhd
endfunction

function! Tb(path)
   if filereadable(a:path)
      "python import vim                                                                                         
      "python import sys                                                                                         
      "python string = vim.eval("a:path")
      "python sys.argv = [string]                                                                                
      "pyfile ~/.vim/fileparse.py
      execute '!python2.7 ~/.vim/fileparse.py' a:path "null"
      r~/.vim/tb_template_1.vhd
      normal G
      r./sigs.vhd                                                                                             
      normal G
      r~/.vim/tb_template_2.vhd
      normal G
      r./inst.vhd 
      normal G	
      r~/.vim/tb_template_3.vhd
      normal G
   else
      r~/.vim/tb_template.vhd
   endif

endfunction

function! Inst(path)                                                                                          
   "python import vim  
   "python import sys   
   "python string = vim.eval("a:path")                                                                        
   "python sys.argv = [string]                                                                                
   "pyfile ~/.vim/fileparse.py
   execute '!python2.7 ~/.vim/fileparse.py' a:path "null"
   r./inst.vhd                                                                                             
endfunction 

function! Inst_sigs(path)                                                                                          
   execute '!python2.7 ~/.vim/fileparse.py' a:path "null"
   r./sigs.vhd                                                                                             
endfunction 

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_vhdl_checkers = ['ghdl']
" End syntastic settings

:set rnu

let mapleader="\<Space>"
nnoremap <leader>c :!ctags -R $TCL_SVN
nnoremap <leader>v :vsplit
nnoremap <leader>t :Tab /
nnoremap <leader>j Lzz
nnoremap <leader>k Hzz
nnoremap <leader>i i_<esc>r
"m doesnt work
nnoremap <leader>m @ 
nnoremap <leader>I :call Inst("
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"noremap! Q q
inoremap jj <ESC>
inoremap <esc> <nop>
noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <RIGHT> <NOP>
noremap <LEFT> <NOP>

"Macros
"set the last signal as marker 's'
let @i = "G?signalms<c-o>"
"make word under cursor a signal
let @s = "yiw'sosignal jjpa : std_logicjjms"


"Functions
nnoremap <leader>g :set operatorfunc=<SID>Grepperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>Grepperator(visualmode())<cr>

function! s:Grepperator(type)
   let saved_unnamed_register = @@

   if a:type ==# 'v'
      normal! `<v`>y
   elseif a:type ==# 'char'
      normal! `<v`>y
   else
      return
   endif

   :call UnixGrep(@@, '.')
   copen

   let @@ = saved_unnamed_register
endfunction

nnoremap <leader>p :set operatorfunc=<SID>PortmapUpdate<cr>g@
vnoremap <leader>p :<c-u>call <SID>PortmapUpdate(visualmode())<cr>

function! s:PortmapUpdate(type)
   let saved_unnamed_register = @@

   if a:type ==# 'v'
      normal! `<v`>"ay?entityw"byiw
   elseif a:type ==# 'char'
      normal! `<v`>"ay?entityw"byiw
   else
      return
   endif

   :call UnixGrep(@b, './*.vhd')
   let myList = getqflist()
   let FileName = @%
   call filter(myList, 'bufname(v:val.bufnr) !~ FileName')
   call setqflist(myList)
   copen

   let @@ = saved_unnamed_register
endfunction

function! UnixGrep(string, dir)
   silent execute "grep! -R " . shellescape(a:string) . " " . a:dir
"   copen
endfunction

function! UnixFind(string)
   :args `find . -type f -iname "*.vhd"`
endfunction


