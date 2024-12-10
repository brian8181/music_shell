#!/bin/bash
FILE=$1

OPTSTRING="abch"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    a)
      echo "Option -a was triggered."
      ;;
    b)
      echo "Option -b was triggered."
      ;;
    c)
      COLOR_OPT="TRUE";
      ;;
     h)
      # display help
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))


SYMBOL='\b[A-Za-z]\w*\b'
PARAMS='\w.*\w'
PARAMS_GRP='('$PARAMS')'
ARRAY_SUBSCRIPT="[\s.*\s]"
BINARY_OPERATORS="==|!=|<=|>=|&&|\|\||++|--|<<|>>[-=<>+*&|#]"
OPERATORS2="{|}|.|->|.*|::|(|)|[|]|'|\"|?|:|%|!|~|^|\\|/|,|;"
TYPES="void|char|int|short|long|single|float|double"
TYPE_QUALIFIER="const|volatile|mutable|restrict"
TYPE_SIGN="signed|unsigned"
STORAGE_CLASS_SPECIFIER="static|auto|register|extern|_Thread_local"
KEYWORDS="if|else|elseif|for|while|do|switch|case|default|break|continue|goto|return"
KEYS2="class|struct|enum|union|inline|virtual"
KEY3="public|protected|private"
K4="new|delete|sizeof"
K5="include|using|namespace"
K6="throw|catch"

TYPE_MODIFIER="*|&"
LITERAL=
EXPRESSION=''
END_LINE=';'


sed -E "s|\s\(|\(|g"                                     # remove space before opening paren. "foo () --> foo()"
sed -E "s|\(\s+(\w.*\w)\s+\)|\(\1\)|g"                   # remove space inside parens "foo( x ) --> foo(x)"
sed -E "s|\((\w.*\w)\)|\( \1 \)|g"                       # adds space inside parens "foo(x) --> foo( x )"
sed -E "s|(\w+)\s+\*(\w+)|\1\* \2|g"                     # int *x --> int* x
sed -E "s|(\w+)\*\s+(\w+)|\1 \*\2|g"                     # int* x --> int *x
sed -E "s|(\w+)==(\w+)|\1 == \2|g"                       # x==0 -> x == 0
sed -E "s/(\w+)(([-=<>+*&|])|(==)|(!=))(\w+)/\1 \2 \6/g" # x[-=<>+*&|]y --> x [-=<>+*&|] y
sed -E 's/([^\s])\s*\{/\1\n{/g' 
# void foo() {
# //
# }
## -->
# void foo() 
# {
# //
# }
sed -E 's/^(\s*)([^\s]*)\s*\{/\1\2\n\1{/g'
#   void foo() {
#   //
#   }
## -->
#   void foo() 
#   {
#   //
#   }
cat -s # squeeze blank lines
cat -n # number lines


