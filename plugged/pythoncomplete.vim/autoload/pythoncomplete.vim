" complete.vim - Omni Completion for python
" Maintainer: Aaron Griffin <aaronmgriffin@gmail.com>
" Version: 0.9
" Last Updated: 18 Jun 2009
"
" Changes
" TODO:
" 'info' item output can use some formatting work
" Add an "unsafe eval" mode, to allow for return type evaluation
" Complete basic syntax along with import statements
"   i.e. "import url<c-x,c-o>"
" Continue parsing on invalid line??
"
" v 0.9
"   * Fixed docstring parsing for classes and functions
"   * Fixed parsing of *args and **kwargs type arguments
"   * Better function param parsing to handle things like tuples and
"     lambda defaults args
"
" v 0.8
"   * Fixed an issue where the FIRST assignment was always used instead of
"   using a subsequent assignment for a variable
"   * Fixed a scoping issue when working inside a parameterless function
"
"
" v 0.7
"   * Fixed function list sorting (_ and __ at the bottom)
"   * Removed newline removal from docs.  It appears vim handles these better in
"   recent patches
"
" v 0.6:
"   * Fixed argument completion
"   * Removed the 'kind' completions, as they are better indicated
"   with real syntax
"   * Added tuple assignment parsing (whoops, that was forgotten)
"   * Fixed import handling when flattening scope
"
" v 0.5:
" Yeah, I skipped a version number - 0.4 was never public.
"  It was a bugfix version on top of 0.3.  This is a complete
"  rewrite.
"
"This is a Hack setting will only work if you have textwidth=80
"eg in your .vimrc. So far I cant get omnifunc to return multiline completions
"
"set textwidth=80
"let g:pythoncomplete_include_super = 1
"
" It will include a formatted super() statement on completing a subclass
" method.
"
"
if !exists('g:pythoncomplete_include_super')
        let g:pythoncomplete_include_super = 0
endif

if exists('did_autoload_python_complete')
	finish
endif
let did_autoload_python_complete = 1

let g:_pcpy='python3 '
if !has('python3')
	if !has('python')
		echohl WarningMsg
		echom  "py3 or 2.7 required"
		echohl None
		unlet g:_pcpy
		finish
	endif
	let g:_pcpy='python '
endif

exec g:_pcpy "from pyaucomplete import vimcomplete"

function! pythoncomplete#Complete(findstart, base)
        if a:findstart == 1
                let line = getline('.')
                let idx = col('.')
                while idx > 0
                        let idx -= 1
                        let c = line[idx]
                        if c =~ '\w'
                                continue
                        elseif ! c =~ '\.'
                                let idx = -1
                                break
                        else
                                break
                        endif
                endwhile
                return idx
        else
                let line = getline('.')
                let idx = col('.')
                let cword = ''
                while idx > 0
                        let idx -= 1
                        let c = line[idx]
                        if c =~ '\w' || c =~ '\.'
                                let cword = c . cword
                                continue
                        elseif strlen(cword) > 0 || idx == 0
                                break
                        endif
                endwhile
                execute g:_pcpy "vimcomplete('" . cword . "', '" . a:base . "')"
                return g:pythoncomplete_completions
        endif
endfunction
