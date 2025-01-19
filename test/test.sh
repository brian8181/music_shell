echo $@ | sed -E "s/([0-9]+)( |$)/\1p;/g"
echo -e 'void foo() { \n\tint x = 0; \n}' | sed -E "s/\{\s*$/\n{/"