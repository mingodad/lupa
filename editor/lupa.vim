" Vim syntax file
" Language:	Lupa

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'lupa'
endif


syn keyword lupaCommentTodo    TODO FIXME XXX TBD contained
syn match   lupaLineComment    "\/\/.*" contains=@Spell,lupaCommentTodo
syn match   lupaCommentSkip    "^[ \t]*\*\($\|[ \t]\+\)"
syn region  lupaComment	       start="/\*"  end="\*/" contains=@Spell,lupaCommentTodo
syn match   lupaSpecial	       "\\\d\d\d\|\\."
"syn match   lupaOperator       "[,;.\-+=*|/\^]"
syn region  lupaStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=lupaSpecialCharacter
syn region  lupaStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=lupaSpecialCharacter
syn region lupaStringD         start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend contains=lupaSpecialCharacter
"syn match   lupaType           "[A-Z$_][a-z_$][a-zA-Z_$0-9]*" display

syn match   lupaComment "\%^#!.*"
syn match   lupaOperator "#"

syn match   lupaSpecialCharacter "'\\.'"

" Numbers
"
syn case ignore

syn match lupaDec	display "\<\d[0-9_]*\(u\=l\=\)\>"
syn match lupaHex	display "\<0x[0-9a-f_]\+\(u\=l\=\)\>"
syn match lupaOctal     display "\<0[0-7_]\+\(u\=l\=\)\>"
syn match lupaBadOctal  display "\<0[0-7_]*[89][0-9_]*"
syn match lupaFloat	display "\<\d[0-9_]*\.[0-9_]*\(e[-+]\=[0-9_]\+\)\="
syn match lupaHexFloat	display "\<0x[0-9a-f_]\+\.[0-9a-f_]*\(p[-+]\=[0-9_]\+\)\="

syn case match

"syn region  lupaRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/+me=e-1

syn keyword lupaConditional	if else switch
syn keyword lupaRepeat		while for do
syn keyword lupaBranch		break continue
syn keyword lupaOperator	in is typeof like 
syn keyword lupaType		Array Table Boolean Error Function Number Object String Type Class Trait Range Fiber Pattern Any Void Nil int8 uint8 int16 uint16 int32 uint32 int64 uint64 float double
syn keyword lupaStatement	return
syn keyword lupaSpecial	        new is as does can init weak raise
syn keyword lupaBoolean		true false
syn keyword lupaConstant	nil
syn keyword lupaIdentifier	var self super our
syn keyword lupaLabel		default case
syn keyword lupaException	try catch finally throw
syn keyword lupaReserved	class export import trait object guard with from static enum
syn keyword lupaFunction	rule function method has needs

if exists("lupa_fold")
    syn match	lupaFunction	"\<function\>"
    syn region	lupaFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match lupaSync	grouphere lupaFunctionFold "\<function\>"
    syn sync match lupaSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword lupaFunction	function method rule has
    syn match	lupaBraces	   "[{}\[\]]"
    syn match	lupaParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "lupa"
  syn sync ccomment lupaComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lupa_syn_inits")
  if version < 508
    let did_lupa_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink lupaComment		    Comment
  HiLink lupaLineComment	    Comment
  HiLink lupaCommentTodo	    Todo
  HiLink lupaSpecial		    Special
  HiLink lupaStringS		    String
  HiLink lupaStringD		    String
  HiLink lupaCharacter		    Character
  HiLink lupaSpecialCharacter	    lupaSpecial

  HiLink lupaDec                    Number
  HiLink lupaHex                    Number
  HiLink lupaOctal                  Number
  HiLink lupaBadOctal		    Error
  HiLink lupaFloat                  Number
  HiLink lupaHexFloat               Number
  HiLink lupaConditional	    Conditional
  HiLink lupaRepeat		    Repeat
  HiLink lupaBranch		    Conditional
  HiLink lupaOperator		    Operator
  HiLink lupaType		    Type
  HiLink lupaStatement		    Statement
  HiLink lupaFunction		    Function
  HiLink lupaBraces		    Function
  HiLink lupaError		    Error
  HiLink lupaParenError		    lupaError
  HiLink lupaNull		    Keyword
  HiLink lupaBoolean		    Boolean
  HiLink lupaRegexpString	    String

  HiLink lupaIdentifier		    Identifier
  HiLink lupaLabel		    Label
  HiLink lupaReserved		    Keyword
  HiLink lupaException		    Exception
  HiLink lupaMember		    Keyword
  HiLink lupaDebug		    Debug
  HiLink lupaConstant		    Label

  delcommand HiLink
endif

let b:current_syntax = "lupa"
if main_syntax == 'lupa'
  unlet main_syntax
endif

" vim: ts=8
