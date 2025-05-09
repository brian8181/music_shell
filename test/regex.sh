DIGIT=[0-9]
SIGN="(-|+)"
DECIMAL="\."
LITERAL_INTEGER="$SIGN?$DIGIT+"
LITERAL_FLOAT="$SIGN?$DIGIT*$DECIMAL$DIGIT+"

SYMBOL='[A-Za-z]\w*'
TYPE_NAME='[A-Za-z_]*'
PARAMS='\w.*\w'
PARAMS_GRP='('$PARAMS')'
ARRAY_SUBSCRIPT="[\s.*\s]"
LOGICAL_OPERS=">|<|==|!=|<=|>=|&&|\|\|"
MATHMATICAL_OPERS='[+-*|%]'
BITWISE_OPERS='[~&|^]'
ASSIGNMENT_OPRS='=|+=|*=|~=|&=|\|=|++|--'
REDIRECTION_OPERS='.|::|.*|->'
TERNARY='[=?:]'
GROUPING_OPERS='[[]{}(),]' 
BINARY_OPERATORS="==|!=|<=|>=|&&|\|\||++|--|<<|>>[-=<>+*&|%]"
OPERATORS2="{|}|.|->|.*|::|(|)|[|]|'|\"|?|:|%|!|~|^|\\|/|,|;"
TYPE="void|char|int|short|long|single|float|double"
TYPE_QUALIFIER="const|volatile|mutable|restrict"
TYPE_SIGN="signed|unsigned"
TYPE_SIGNED="signed"
TYPE_UNSIGNED="unsigned"
TYPE_POINTER="*"
TYPE_REFERENCE="&"

STORAGE_CLASS_SPECIFIER="static|auto|register|extern|_Thread_local"
KEYWORDS="if|else|elseif|for|while|do|switch|case|default|break|continue|goto|return"
OBJECT_TYPES="class|struct|enum|union|inline|virtual"
VISIBILITY="public|protected|private"
MEMORY="new|delete|sizeof"
SCOPE="include|using|namespace" 
EXCEPTION="throw|catch"

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
echo Input: 
echo -e 'void foo() { \n\tint x = 0; \n}'
echo Result:
echo -e 'void foo() { \n\tint x = 0; \n}' | sed -E "s/\{\s*$/\n{/"
echo -e '\tvoid foo() { \n\t\tint x = 0; \n\t}' | sed -E 's/(^(\s*)[^\s]*)\s*\{/\1\n\2{/g' 

# space after '(' space before ')'
# space before '('
# no space after '(' no space before ')'
# no space before '('
# # space before '(' AND # space after '(' space before ')'
# # no space before '(' AND # no space after '(' no space before ')'

# no space before '(' # AND # no space after '(' no space before ')' #
# int foo (int x) --> int foo(int x)
# int foo ( int x ) --> int foo(int x)
sed -E "s/^\s*($TYPE_QUALIFIER)?\s*($TYPE)\s($SYMBOL)\s*\(\s*($TYPE)\s+($SYMBOL)\s*\)/\1\2 \3\(\4 \5\)/"

# no space before '(' # AND # space after '(' space before ')'
SPACE_BEFORE_OPEN_PAREN='int foo(int x) --> int foo (int x)'
NO_SPACE_BEFORE_OPEN_PAREN='int foo (int x) --> int foo(int x)'
SPACE_AFTER_OPEN_PAREN_SPACE_BEFORE_CLOSE_PAREN='int foo (int x) --> int foo( int x )'

NO_SPACE_BEFORE_OPEN_PAREN_AND_SPACE_AFTER_OPEN_PAREN_SPACE_BEFORE_CLOSE_PAREN='int foo ( int x ) --> int foo( int x )'
sed -E "s/^\s*($TYPE_QUALIFIER)?\s*($TYPE)\s($SYMBOL)\s*\(\s*($TYPE)\s+($SYMBOL)\s*\)/\1\2 \3\( \4 \5\ )/"
# echo $@ | sed -E "s/([0-9]+)( |$)/\1p;/g"

cat -s # squeeze blank lines
cat -n # number lines
