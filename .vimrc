""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""
"取消换行自动注释, 这个没有用
" au FileType php setlocal comments-=:// comments+=f://
"可以在需要粘贴之前执行一下 set paste
"set paste
syntax on
syntax enable
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
set go=             " 不要图形按钮
colorscheme koehler2 "设置主题
set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set foldenable      " 允许折叠
set foldmethod=manual   " 手动折叠
set lbr
set fo+=mB
set sm
set wildmenu
set mousemodel=popup


""""""""""""""""""""""""""""
" 显示中文帮助
""""""""""""""""""""""""""""
if version >= 603
	set helplang=cn
	set encoding=utf-8
    set completeopt=menu,longest,preview  "自动补全Ctrl+p时的一些选项：多于一项时显示菜单，最长选择，显示当前选择的额外信息
endif


""""""""""""""""""""""""""""
" 缩进 
""""""""""""""""""""""""""""
set autoindent " 自动缩进
set cindent " c语言缩进
set tabstop=4 " Tab键的宽度
set softtabstop=4 " 统一缩进为4
set shiftwidth=4 "设定>命令移动时宽度为4 
set expandtab " 使用空格代替制表符
set smarttab " 在行和段开始处使用制表符
set smartindent " C自动缩进


""""""""""""""""""""""""""""
" 搜索设置
""""""""""""""""""""""""""""
set number
set history=1000 " 历史记录数
set hlsearch " 搜索时高亮显示被找到的文件
set incsearch  " 输入搜索内容时就显示搜索结果 


""""""""""""""""""""""""""""
" 语言设置
""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn

""""""""""""""""""""""""""""
" 其他
""""""""""""""""""""""""""""
filetype on " 侦测文件类型
filetype plugin on " 载入文件类型插件
filetype indent on " 为特定文件类型载入相关缩进文件
filetype plugin indent on
set viminfo+=!  " 保存全局变量
set iskeyword+=_,$,@,%,#,-,. " 带有如下符号的单词不要被换行分割

set autoread " 设置当文件被改动时自动载入
set autowrite " 自动保存

"set clipboard+=unnamed "共享剪贴板
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
" set foldcolumn=0
" set foldmethod=indent
" set foldlevel=3
set nocompatible  "不要使用vi的键盘模式，而是使用自己的，去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set noeb " 去掉输入错误的提示声音
set confirm " 在处理未保存或只读文件的时候，弹出确认
set nobackup "禁止生成临时文件
set noswapfile
set linespace=0
set wildmenu " 增强模式中的命令行自动完成操作
set backspace=2 " 使回格键（backspace）正常处理indent, eol, start等
set mouse=a " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive
set selectmode=mouse,key
set report=0 " 通过使用: commands命令，告诉我们文件的哪一行被改变过
" set fillchars=vert:\ ,stl:\ ,stlnc:\ " 在被分割的窗口间显示空白，便于阅读
set showmatch " 高亮显示匹配的括号
set matchtime=1 " 匹配括号高亮的时间（单位是十分之一秒）




""""""""""""""""""""""""""""
" 键盘命令
""""""""""""""""""""""""""""
" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
map <F12> gg=G
map <C-w> <C-w>w
imap <C-k> <C-y>,
imap <C-t> <C-q><TAB>
" imap <C-j> <ESC>
" 选中状态下 Ctrl+c 复制
" map <C-v> "*pa
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y
set mouse=v
" set clipboard=unnamed


inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>


""""""""""""""""""""""""""""
" C，C++ 按F5编译运行
""""""""""""""""""""""""""""
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'py'
    exec "!time python3 %"
  elseif &filetype == 'php'
    exec "!time php %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'go'
    "        exec "!go build %<"
    exec "!time go run %"
  elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!firefox %.html &"
  endif
endfunc


""""""""""""""""""""""""""""
" C,C++的调试
""""""""""""""""""""""""""""
map <F8> :call Rungdb()<CR>
func! Rungdb()
  exec "w"
  exec "!g++ % -g -o %<"
  exec "!gdb ./%<"
endfunc


""""""""""""""""""""""""""""
" 代码格式优化化
""""""""""""""""""""""""""""
map <F6> :call FormartSrc()<CR><CR>
" 定义FormartSrc()
func FormartSrc()
  exec "w"
  if &filetype == 'c'
    exec "!astyle --style=ansi -a --suffix=none %"
  elseif &filetype == 'cpp' || &filetype == 'hpp'
    exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
  elseif &filetype == 'perl'
    exec "!astyle --style=gnu --suffix=none %"
  elseif &filetype == 'py'||&filetype == 'python'
    exec "r !autopep8 -i --aggressive %"
  elseif &filetype == 'java'
    exec "!astyle --style=java --suffix=none %"
  elseif &filetype == 'jsp'
    exec "!astyle --style=gnu --suffix=none %"
  elseif &filetype == 'xml'
    exec "!astyle --style=gnu --suffix=none %"
  else
    exec "normal gg=G"
    return
  endif
  exec "e! %"
endfunc
"结束定义FormartSrc


" 恢复文件关闭之前光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


""""""""""""""""""""""""""""
"可以建立源码树的标签索引（标签就是一个标识符被定义的地方，如函数定义），使程序员在编程时能迅速定位函数、变量、宏定义等位置去查看原形
" Tag list (ctags) 列出了当前文件中的所有宏, 全局变量, 函数名等
"""""""""""""""""""""""""""""
" let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树
"let Tlist_Sort_Type = "name"    " 按照名称排序
"let Tlist_Compart_Format = 1    " 压缩方式
"let Tlist_Ctags_Cmd='/usr/bin/ctags'  " 设定ctags程序路径
"let Tlist_Show_One_File=1             " 不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Exit_OnlyWindow=1           " 如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1          " 在右侧窗口显示taglist窗口
"let Tlist_Use_SingleClick=1         " 单击tag就跳转
"" let Tlist_Close_On_Select=1         " 选择tag后自动关闭taglist
"" let Tlist_File_Fold_Auto_Close=1  " 多文件时只显示当前文件的tag，其它的tag折叠
"let Tlist_WinHeight=200       " taglist窗口高度
"let Tlist_WinWidth=20        " taglist窗口宽度
"" let Tlist_Use_Horiz_Window=1   " 设置taglist窗口横向显示
"" let Tlist_Auto_Open=1
"" 映射F9打开关闭taglist窗口
"map <expr> <F9> bufloaded("__Tag_List__")?"q":":TlistOpen\<cr>"
"" nmap <silent> <F9> <ESC>:Tlist<RETURN>
"" 设置tags
"set tags=tags;
"set autochdir

"""""""""""""""""""
"tagbar配置
"""""""""""""""""""
"将开启tagbar的快捷键设置为　<Leader>tb
nnoremap <silent> <F9> :TagbarToggle<CR>
" 设置ctags所在路径
let g:tagbar_ctags_bin='/usr/bin/ctags'  
let g:tagbar_width=20


" minibufexpl插件的一般设置 这个插件使用来打开多个文件,tab切换的
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
nmap tl :Tlist<cr>

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


"自动补齐双引号，括号等
Plug 'vim-scripts/Auto-Pairs'

"模糊搜索，非常慢
"Plug 'ctrlp-funky'
"Plug 'ctrlp-modified.vim'
"Plug 'ctrlp.vim'
""grep模糊搜索比较快
"cscope 已经包含了grep功能，如果关闭cscope， 需要打开，并设置F3快捷键,
"在需要手动输入查询关键词的时候还是很好用的
Plug 'vim-scripts/grep.vim'

"注释
Plug 'vim-scripts/DoxygenToolkit.vim'
""快速注释
Plug 'scrooloose/nerdcommenter'

" phpdoc
" Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'

" https://github.com/tobyS/pdv
" 这个太旧了 php会报错
" Plug 'tobyS/pdv'

Plug 'Rican7/php-doc-modded'

""用细竖线显示缩进级别
" Plug 'Yggdroot/indentLine'

Plug 'vim-scripts/L9'
":w
"Undotree NERDTree ctrlp Surround NERDCommenter neocomplete YouCompleteMe Syntastic AutoClose Fugitive PIV Ack.vim Tabularize Tagbar EasyMotion Airline 
"Plug 'spf13/PIV' 
"最后修改 
Plug 'vim-scripts/last_edit_marker.vim' "文件打开历史记录
Plug 'vim_scripts/mru.vim'

"代码块补充
Plug 'honza/vim-snipmate'
Plug 'vim-scripts/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

"Plug 'vim-scripts/SQLComplete.vim'
"高亮选中区域
Plug 'vim-scripts/synmark.vim'
"语法检测
Plug 'vim-syntastic/syntastic'

"airline
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"对齐插件, 同类插件tabular，大家都比较推荐vim-easy-align
Plug 'junegunn/vim-easy-align'
"以可视化方式选择更大区域
"Plug 'terryma/vim-expand-region'
"多选项
Plug 'terryma/vim-multiple-cursors'
"快速滑动
"Plug 'terryma/vim-smooth-scroll'

"zendcoding, surround对css,html补全友好
"Plug 'vim-scripts/ZenCoding.vim'
Plug 'tpope/vim-surround'

"自动补全有四类
"1）已经使用过的关键词（包括自定义的关键词） AutoComplPop
"2)系统函数补全 dict字典也行，complete也行
"3）代码块补全 snipMate
"4)自定义的函数和方法提示  phpcomplete
"
"另外要注意phpcomplete是在Omni completion基础上完成的，使用<c-x><c-o>补全,
"是以tags 文件为基础的, 要注意只能在本项目中, 否则会很慢，很卡，并且没有提示

"第二次改动，youcompleteme 是在时太慢了，果断关掉,世界都变美好了
"youcompleteme在phpcomplete和phpcd的基础上，原本要使用ctrl+x ctrl+o才能只能补全的，现在一边敲代码一边就能补全了
"YouCompleteMedu的关键词补全 "使用的是自己的那一套，比如array_slice就只提示array_slice，不提示函数参数这些等，所以不想用他自身的
"
"业务相关，如果是timingyiinew项目不开启ycm和phpcd
if $PWD != '/webser/www/timingyiinew'
    " Plug 'Valloric/YouCompleteMe'
    "开启了phpcd.vim 导致了不能自动提醒类和方法，没有找到原因，先关闭
    Plug 'lvht/phpcd.vim'
endif
"php的自动补全 phpcd也是代码补全，更快，更高效
Plug 'shawncplus/phpcomplete.vim'
"编辑过的变量和函数自动弹出, 自定义的
"由于youcompleteme已经包含了autocompPop,所以开启了youcompleteme就不需要在使用autocomplPop
Plug 'vim-scripts/AutoComplPop'

"这个包含了很多功能，很有用, 有空看一下
"Plug 'phpactor/phpactor'

"
""PHP CodeSniffer、PHP编码标准修复程序、Linter和Mess检测器支持卓越的文本, 暂时先不用
Plug 'benmatselby/sublime-phpcs'
""vdebug,用于Vim的多语言DBGP调试器客户端（PHP，Python，Perl，Ruby等）
"Plug 'vim-vdebug/vdebug'


""python自动补全
"Pydiction允许您在Vim中使用Tab-complete
"Python代码，例如关键字，内置函数，标准库和第三方模块
Plug 'vim-scripts/Pydiction'
"代码完成，代码提示
"Plug 'humiaozuzu/dot-vimrc'
"python的vim
"Plug 'prompt-toolkit/pyvim'
"跳转和移动
"Plug 'Crapworks/python_fn.vim'
"可以导入import
Plug 'fsouza/pythoncomplete.vim'
"
"jedi-vim python-mode可以替代pythoncomplete 和Pydiction 但是太慢了
"Plug 'davidhalter/jedi-vim'
"Plug 'python-mode/python-mode'

"django, python web框架
Plug 'vim-scirpts/django_templates.vim'
Plug 'pydanny/cookiecutter-django'

"java
Plug 'artur-shaik/vim-javacomplete2'

"js
"js格式化
Plug 'maksimr/vim-jsbeautify'
"在Vim中 大大改进了Javascript缩进和语法支持
Plug 'pangloss/vim-javascript'

"Plug 'andrewfiorillo/sketch-palettes'
"
"
"go
Plug 'fatih/vim-go'

"提升速度
"Plug 'easymotion/vim-easymotion'
"自动检测多种编码
Plug 'vim-scripts/fencview.vim'
""离开/重新进入插入模式时保持并恢复中文输入发状态
Plug 'vim-scripts/fcitx.vim'
"todo 跟ctags差不多，但是比ctags强大很多，有空要看, 与ctagsU不能兼容``
"Plug 'simplyzhao/cscope_maps.vim'
""预览中的自动展示功能参数, 可以看到函数的参数
Plug 'vim-scripts/autoproto.vim'
"
 
" 目录树
Plug 'scrooloose/nerdtree'
"在使用 NERDTree 的过程中有一些不太方便的地方就是打开的各个文件不共享
"NERDTree，所以就需要配合安装一个共享插件 vim-nerdtree-tabs，
"这就让你感觉只是打开了一个 NERDTree
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"git
Plug 'tpope/vim-fugitive'
Plug 'kablamo/vim-git-log'

"自动加载和错误解析
Plug 'tpope/vim-dispatch'
"源码列表，方法和函数列表
"Plug 'vim-scripts/taglist.vim'
"tagbar是一个taglist的替代品，比taglist更适合c++使用，函数能够按类区分，支持按类折叠显示等，显示结果清晰简洁，强烈推荐
Plug 'majutsushi/tagbar'

"gdb interface
Plug 'vim-scripts/gdbmgr'
"该插件可以显示撤消历史记录，并且可以更轻松地在不同的撤消分支之间进行浏览和切换
Plug 'mbbill/undotree'

"go
Plug 'godoctor/godoctor.vim'
Plug 'fatih/vim-go'
"所有插入都转换成tab
"youcompleteme包含了supertab这个功能，所以如果打开了youcompleteme就可以不适用supertab.vim了
Plug 'wenshuai-xi/supertab.vim'


"中文文档
Plug 'yianwillis/vimcdoc'

"win管理
Plug 'vim-scripts/winmanager'




" " Initialize plugin system
call plug#end()

let g:go_version_warning = 0

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


""""""""""""""""""""""""""""
"ctrlp设置 它可以快速的帮助我们找到项目中的文件 快捷键：ctrl+p
""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']


""""""""""""""""""""""""""""
"Grep
"""""""""""""""""""""""""""""
"vim-script/grep
""如果不使用cscope 就开启Rgrep,(无论如何。还是要开着的)
nnoremap <silent> <F3> :Rgrep<CR>
"grepper
"nnoremap <silent> <F3> :Grepper<CR>


""""""""""""""""""""""""""""
"MRU
"""""""""""""""""""""""""""""
"let MRU_File=$HOME.'/.vim/config/_vim_mru_files'  "把记录保存在哪
""let MRU_Max_Entries=10                          "最多保存多少条记录
"let MRU_Window_Height=8                         "设置MRU窗口高度
let MRU_Use_Current_Window=0                     "设置是否让MRU窗口独点一页, 设置为1的话在当前窗口打开  mru list
"映射F2打开和关闭MRU窗口，bufloaded是判断缓冲是否加载
"map <expr> <F2> bufloaded("__MRU_Files__")?"q":":CtrlPMRU\<cr>"
map <expr> <F2> bufloaded("__MRU_Files__")?"q":":MRU\<cr>"
let MRU_Filename_Format={'formatter':'v:val', 'parser':'.*'} 



""""""""""""""""""""""""""""
"NERDTree
""""""""""""""""""""""""""""
let NERDChristmasTree=1            "让Tree把自己给装饰得多姿多彩些
"let NERDTreeAutoCenter=1 "控制光标移动超过一定距离时，是否自动将焦点y调整到屏中心
"let NERDTreeAutoCenterThreshold=1  "与上面配合使用
"let NERDTreeCaseSensitiveSort=1    "排序时是否大小写敏感
let NERDTreeHighlightCursorline=1  "是否高亮显示光标所在行
"let NERDTreeBookmarksFile='/root/vim/bookmark.txt'  "指写书签文件
let NERDTreeMouseMode=2 "指定鼠标模式：1为双击打开，3为单击打开，2为目录为单击打开，文件双击打开
let NERDTreeShowBookmarks=1        "是否默认显示书签列表
let NERDTreeShowFiles=1            "是否默认显示文件
let NERDTreeShowHidden=1           "是否默认显示隐藏文件
"let NERDTreeShowLineNumbers=1      "是否默认显示行号
"let NERDTreeSortOrder= "排序规则，这个就麻烦了，可以用正则表达式
"let NERDTreeStatusline=             "窗口状态栏
"let NERDTreeWinPos='right'          "窗口位置（left or right）
"let NERDTreeWinSize=20             "窗口宽
let NERDTreeDirArrows=0 "垂直对齐符号，目录 1 显示箭头  0传统+-|号 如果不设置 就是方框
"映射F7打开关闭NERDTree窗口
"winnr()    获取当前窗口窗口ID
"winbufnr(winnr())   获取当前窗口的缓冲区ID
"bufname(winbufnr(winnr()))  获取当前窗口缓冲区的名字
"strpart(bufname(winbufnr(winnr())), 10) 截取从缓冲区名字第10字符开始到结束
map <expr> <F7> bufloaded("NERD_tree_".strpart(bufname(winbufnr(winnr())),10))?"q":":NERDTreeToggle\<cr>"
"列出当前目录文件
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree  | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let NERDTreeIgnore=['\.pyc']

"""当打开vim且没有文件时自动加载最后编辑的文件，这个会导致nerdtree错乱，所以还是用ctrl+y加载最后一次打开文件，用ctrl+o 多次来查看历史打开文件
""au VimLeave * mks! $HOME/Session.vim
""if expand("%")==""
 ""   if(expand("$HOME/Session.vim")==findfile(expand("$HOME/Session.vim")))
 ""       silent :source $HOME/Session.vim
 ""   endif
""endif

""""""""""""""""""""""""""""
"设置状态栏
""""""""""""""""""""""""""""
":AirlineTheme <theme>
"let g:airline_theme='base16_tomorrow'
let g:airline_statusline_ontop = 1
"let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"设置命令行和状态栏
"set cmdheight=1                 "设定命令行的行数为1
"set laststatus=2                "显示状态栏(默认值为1，无法显示状态栏)
""windows:  set statusline=%F%m%r,%Y,%{&fileformat}\\\ASCII=\%b,HEX=\%B\\\ %l,%c%V\ %p%%\\\[\%L\ lines\ in\ all\]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set statusline=%F%m%r\ %{FugitiveStatusline()}\ ASCII=\%b,HEX=\%B,%l,%c%V\ %L-%p%%
"set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
"
"vim-git-log
":GitLog lib

""""""""""""""""""""""""""""
"语言环境
""""""""""""""""""""""""""""
set encoding=utf-8
"langua message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,gb2312
"设置字符编码列表
"set guifontwide=微软雅黑:h14 "设置中文的字体
set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI:b  "设置英文的字体 :b加粗 :i斜体
set termencoding=utf-8


""""""""""""""""""""""""""""
"映射,F4执行ctags命令
""""""""""""""""""""""""""""
"map <F4> :!/usr/bin/ctags -f tags -R --languages=php --fields=+iaS --extra=+q<cr>
nmap <F4> :call AutoUpdateCscopeAndTags()<cr> 

function AutoUpdateCscopeAndTags() 
    call AutoUpdateTags()
    call AutoCreateCscopeFiles()
    call AutoUpdateCscopeOut()
    call AutoResetCscopeOut()
endfunction

function AutoUpdateTags()
    "c
    "!/usr/bin/ctags -f tags -R --languages=php --C-kinds=+p --fields=+iaS --extra=+q 
    "php
    !/usr/bin/ctags -f tags -R --languages=php --PHP-kinds=+cidfv --fields=+iaS --extra=+q
endfunction
function AutoCreateCscopeFiles()
    !find  $PWD -name '*.php'> cscope.files
endfunction
function AutoUpdateCscopeOut()
    !cscope -Rbq -i cscope.files
endfunction
function AutoResetCscopeOut()
    cs reset 
endfunction

"获取当前文件名
function GetFileName()
    return bufname(winbufnr(winnr()))  "获取当前窗口缓冲区的名字
endfunction

"获取当前时间，精确到分
function GetDateTime()
    return strftime("%Y-%m-%d %H:%M")
endfunction


""""""""""""""""""""""""""""
"屏幕切换
""""""""""""""""""""""""""""
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l


""""""""""""""""""""""""""""
"vim-easy-align 配置
""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
" 进入easyalign模式
xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"
"使用方法 选中需要排版的区域，比如要按照=对齐 就用ga=  vipga= 选中paragraph执行按照=对齐操作

""""""""""""""""""""""""""""
"vim-smooth-scroll 配置
""""""""""""""""""""""""""""
"ctrl+u up ctrl+d down ctrl+b up  
"smooth_scroll 第一个参数表示滚动总行数， 第二个表示时间，第三个表示速度
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

""""""""""""""""""""""""""""
"snipMate默认触发减是tab 修改为ctrl+j
""""""""""""""""""""""""""""

""""""""""""""""""""""""""""
"php开启自动补全
""""""""""""""""""""""""""""
autocmd FileType php set omnifunc=phpcomplete#CompletePHP "如果只有phpcomplete需要打开，如果跟phpcd一起用就使用下面的phpcd中的setlocale
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_min_num_of_chars_for_namespace_completion = 1
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
""关键词补全快捷键


"业务相关，如果是timingyiinew项目不开启ycm和phpcd
if $PWD != '/webser/www/timingyiinew'
""phpcd设置
    let g:phpcd_root = '/'
    let g:phpcd_php_cli_executable = '/usr/bin/php'
    autocmd FileType php setlocal omnifunc=phpcd#CompletePHP
    let g:phpcd_disable_modifier=0
endif

"查看omni complete 文档:help compl-omni-filetypes

""""""""""""""""""""""""""""
"DoxygenToolkit
""""""""""""""""""""""""""""
let g:DoxygenToolkit_commentType = "php"
let g:DoxygenToolkit_briefTag_pre = "@brief\t "
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_post = ""
let g:DoxygenToolkit_templateParamTag_pre = "@tparam\t "
let g:DoxygenToolkit_paramTag_pre = "@param\t "
let g:DoxygenToolkit_returnTag = "@return\t "
let g:DoxygenToolkit_throwTag_pre = "@throw\t "
let g:DoxygenToolkit_fileTag = "@script\t "
let g:DoxygenToolkit_dateTag = "@modify\t "
let g:DoxygenToolkit_authorTag = "@author\t "
let g:DoxygenToolkit_versionTag = "@version\t "
let g:DoxygenToolkit_versionString = "1.0.0"
let g:DoxygenToolkit_blockTag = "@name\t "
let g:DoxygenToolkit_classTag = "@class\t "
let g:DoxygenToolkit_authorName = "yuyangyang<yuyangyang@126.com>"
let g:doxygen_enhanced_color = 1
nmap \hh :DoxAuthor<CR><ESC>k8==j$a
nmap \ff :Dox<CR><ESC>k8==j$a<TAB>
nmap \da :DoxAuthor<CR><ESC>k8==
nmap \db :DoxBlock<CR><ESC>k8==

" syntastic相关
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*let 
"打开文件时高亮显示错误
let g:syntastic_always_populate_loc_list = 1
"打开报错窗口
let g:syntastic_auto_loc_list = 1 
"打开文件时自动进行检查
let g:syntastic_check_on_open = 1
"进行实时检查，如果觉得卡顿，将下面的选项置为1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
"  python pylint
"let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_checkers=['python']
"php
let g:syntastic_php_checkers=['php']
"let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py,*.php exec ":call SetTitle()"
" 定义函数SetTitle，自动插入文件头
func SetTitle()
  " 如果文件类型为.sh文件
  if &filetype == 'sh'
    call setline(1,"\#!/bin/bash")
    call append(line("."), "")
    call append(line(".")+1, "")
  elseif &filetype == 'python'
    call setline(1,"#!/usr/bin/env python")
    call append(line("."),"# coding=utf-8")
    call append(line(".")+1, "")
    call append(line(".")+2, "")
  elseif &filetype == 'ruby'
    call setline(1,"#!/usr/bin/env ruby")
    call append(line("."),"# encoding: utf-8")
    call append(line(".")+1, "")
    call append(line(".")+2, "")
  elseif &filetype == 'php'
    call setline(1,"<?php")
    call append(line("."), " ")
    call append(line(".")+1, "")
    call append(line(".")+2, "/*")
    call append(line(".")+3, " * author：yuyangyang")
    call append(line(".")+4, " * date：".strftime("%Y/%m/%d")) 
    call append(line(".")+5, " * description：") 
    call append(line(".")+6, " */")
    call append(line(".")+7, "")
    call append(line(".")+8, "")
  elseif &filetype == 'mkd'
    call setline(1,"<head><meta charset=\"UTF-8\"></head>")
  else
    call setline(1, "/*************************************************************************")
    call append(line("."), "	> File Name: ".expand("%"))
    call append(line(".")+1, "	> Author: ")
    call append(line(".")+2, "	> Mail: ")
    call append(line(".")+3, "	> Created Time: ".strftime("%c"))
    call append(line(".")+4, " ************************************************************************/")
    call append(line(".")+5, "")
  endif

	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G

"Undotree
"Undotree 查看文件修改历史
nnoremap <F10> :UndotreeToggle<cr>

"-----------------------------------------------------------------
"
"" plugin - cscope设置
"find . -name '*.php'> cscope.files
"像ctags一样，需要提前生成cscope.out文件。cscope -Rbq -i cscope.files, 然后在执行:cs add cscope.out
"-----------------------------------------------------------------
"
"设置cscope的列表color
""参考：https://github.com/jonathanfilip/vim-lucius/issues/3"
"hi ModeMsg ctermfg=Green  #可以颜色主题的vim文件中设置

if has("cscope")  
    set csprg=/usr/bin/cscope "指定了执行cscpoe的命令 
    set csto=1 "假如’csto’被设置为0，那么cscope数据将会被优先查找，假如cscope没有返回匹配项，然后才会查找tag文件。反之，则查找顺序相反。默认值是0 
    set cst "同时查找cscope数据库和tags文件 
    set nocsverb  

	if filereadable("cscope.out")  
        cs add cscope.out  
    "else search cscope.out elsewhere  
    else 
        let cscope_file=findfile("cscope.out",".;")  
        let cscope_pre=matchstr(cscope_file,".*/")  
        if !empty(cscope_file) && filereadable(cscope_file)  
            exe "cs add" cscope_file cscope_pre  
        endif        
    endif  

    " add any database in current directory"
    "if filereadable("/webser/www/timingyiinew/cscope.out")
    "    cs add /webser/www/timingyiinew/cscope.out
    "endif
    set csverb "没有被设置（默认情况是如此），那么当在增加一个cscope数据库时不会显示表示表示执行成功或失败的信息
endif

"s/0查找这个C符号
"nmap <C-s> :cs find s <C-R>=expand("<cword>")<CR><CR>
"g/1查找这个定义
"nmap <C-g> :cs find g <C-R>=expand("<cword>")<CR><CR>
"c/3查找调用这个函数的函数（们）
"nmap <C-c> :cs find c <C-R>=expand("<cword>")<CR><CR>
"4或者t 查找这个字符串
"nmap <C-t> :cs find t <C-R>=expand("<cword>")<CR><CR>
" 6或者e  —— 查找这个egrep匹配模式
nmap <C-e> :cs find e <C-R>=expand("<cword>")<CR><CR>
"7或者f   —— 查找这个文件
nmap <C-f> :cs find f <C-R>=expand("<cfile>")<CR><CR>
"8或者i   —— 查找#include这个文件的文件（们）
nmap <C-i> :cs find i <C-R>=expand("<cfile>")<CR><CR>
" 2或者d  —— 查找被这个函数调用的函数（们）
"c-d 冲突了
nmap <C-d> :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-]> :cs find 1 <C-R>=expand("<cword>")<CR><CR>
nmap <C-\> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map <C-T> <C-O>


"打开vim 自动加载最后编辑的文件 ctrl+y  或者多次ctrl+o
"nmap <C-y> g'Z
"augroup LastEditMarker
"    autocmd!
"    autocmd InsertLeave * normal mZ
"augroup END
"map <c-o>


inoremap <leader><leader> <C-x><C-o>


"""""""""""""""""""""""""""
"youcompleteme自动补全配置
"""""""""""""""""""""""""""
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
"set completeopt=longest,menu
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"
"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
"关闭加载.ycm_extra_conf.py提示
let g:ycm_confirm_extra_conf=1 
let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 "从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
"nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>    "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
"
" "在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" "在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" "注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

let g:ycm_add_preview_to_completeopt =1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>  "跳转到定义处

"YouCompleteMe的提示符设置
let g:ycm_semantic_triggers =  { 'c' : ['->', '.'], 'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'], 'ocaml' : ['.', '#'], 'cpp,objcpp' : ['->', '.', '::'], 'perl' : ['->'], 'php' : ['->', '::', '\'], 'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'], 'ruby' : ['.', '::'], 'lua' : ['.', ':'], 'erlang' : [':']}
"YouCompleteMe只补全以下类型文件
let g:ycm_filetype_whitelist = { 'c':1, 'cpp':1, 'objc':1, 'sh':1, 'zsh':1, 'zimbu':1, 'php':1, 'python':1,'go':1} 


"""""""""""""""
"nerdcommenter 
"""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" " Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
"" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
"常用快捷键使用help nerdcommenter
" \cc  \cn \cu

"fugitive.vim
"使用do dp 处理修改
nnoremap <silent> <C-k> :Gvdiff<CR>
nnoremap <silent> <C-l> :Gblame<CR>

"vim-multiple-cursors
"使用方法 使用ctrl+n选中多列，s 查找并替换，输入替换字符，按esc即可

"set tags+=~/.vim/systags
"set tags+=/webser/www/tags
"set tags+=/webser/www/timingyiinew/tags
"set tags+=/webser/www/laravel-master/tags
set tags+=./tags

"粘贴内容时不自动缩进
set pastetoggle=<F11> 

"python补全
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
let g:pydiction_menu_height = 20


"set completeopt=longest,menui,preview ""自动补全


"只要有~/.vim/dict 就可以添加下面这些自动提示了
"#函数的自动提示，不需要按<c-x><c-o>,
"但是只提示函数名称,""<c-x><c-o>可以提示完整的函数参数和类型 
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"ctags搜索代码时, 用 ctrl + ] , 缺省情况下, vim会把你带到第一个匹配的地方,
"该配置可以列出所有匹配列表
map <c-]> g<c-]>

""""""""""""""""""""""
"todo vim-multiple-cursors
"""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"

"不生效
inoremap { {<CR>}<Up><Enter>

"if exists("g:equ")
":inoremap = <c-r>=EqualSign('=')<CR>
":inoremap . <c-r>=EqualSign('.')<CR>
":inoremap + <c-r>=EqualSign('+')<CR>
":inoremap - <c-r>=EqualSign('-')<CR>
":inoremap * <c-r>=EqualSign('*')<CR>
":inoremap / <c-r>=EqualSign('/')<CR>
":inoremap > <c-r>=EqualSign('>')<CR>
":inoremap < <c-r>=EqualSign('<')<CR>
":inoremap , ,<space>
"endif


function! EqualSign(char)
    if a:char  =~ '='  && getline('.') =~ ".*("
        return a:char
    endif 
    let ex1 = getline('.')[col('.') - 3]
    let ex2 = getline('.')[col('.') - 2]


    if ex1 =~ "[-=+><>\/\*]"
        if ex2 !~ "\s"
            return "\<ESC>i".a:char."\<SPACE>"
        else
            return "\<ESC>xa".a:char."\<SPACE>"
        endif 
    else
        if ex2 !~ "\s"
            return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
        else
            return a:char."\<SPACE>\<ESC>a"
        endif 
    endif
endfunction

let g:snips_author = 'yuyangyang'

"DEBUG
"set vbs=4
"
"fish 和bash 的语法不一样，所以不能让vim 使用 fish 作为外部解释器
if &shell =~ '/bin/fish'
    set shell=/bin/bash
endif

" 修改默认编辑器
"export EDITOR=/usr/local/bin/vim
" fish 和bash 的语法不一样，所以你不能让vim 使用 fish 作为外部解释器
 if &shell =~ '/bin/fish'
     set shell=/bin/bash
 endif

" 禁止换行自动生成注释c
 augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " This can be done as well instead of the previous line, for setting formatoptions as you choose:
    autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END


" PHP documenter script bound to Control-P
autocmd FileType php inoremap <C-p> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-p> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-p> :call PhpDocRange()<CR>
