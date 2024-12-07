#!/bin/bash

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