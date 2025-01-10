echo -en "\n"
echo -e "Example 1: Brace On New Line"
echo -e "\nInput:" 
echo -e 'void foo() { \n\tint x = 0; \n}'
echo -e "\nResult:"
echo -e 'void foo() { \n\tint x = 0; \n}' | sed -E "s/\{\s*$/\n{/"
echo -en "\n"

echo -e "Example 2: Brace on New Line with Tabs"
echo -e "\nInput:"
echo -e '\tvoid foo() { \n\t\tint x = 0; \n\t}' 
echo -e "\nResult:"
echo -e '\tvoid foo() { \n\t\tint x = 0; \n\t}' | sed -E 's/(^(\s*)[^\s]*)\s*\{/\1\n\2{/g' 
echo -en "\n"

echo -e "Example 3: No Space Before Open Paren"
echo -e "\nInput:"
echo -e 'void foo ()' 
echo -e "\nResult:"
echo -e 'void foo ()' | sed -E "s|\s\(|\(|g"
echo -en "\n"

echo -e "Example 4: Remove Space Inside Parens"
echo -e "\nInput:"
echo -e 'void foo( int x )' 
echo -e "\nResult:"
echo -e 'void foo( int x )' | sed -E "s|\(\s+(\w.*\w)\s+\)|\(\1\)|g"  
echo -en "\n"

echo -e "Example 5: Space Inside Parens"
echo -e "\nInput:"
echo -e 'void foo(int x)' 
echo -e "\nResult:"
echo -e 'void foo(int x)' | sed -E "s|\((\w.*\w)\)|\( \1 \)|g"   
echo -en "\n"