# 1. Save old $IFS
oldIFS="$IFS"

# 2. Now set up a new value to :
IFS=":"

# 3. Search for the user named 'vivek' /etc/passwd and store result into $result
result=$(grep "\\|Pink Moon\\|\\|08\\|" "../cache/cache.txt")
echo "$result"

# 4. Print user 'vivek's directory  and shell fields
set -- $result
echo "DIR : $6"
echo "Shell : $7"

# 5. Try bash for loop
for i in $result; do echo "$i"; done

# 6. Restore $IFS
IFS="$oldIFS"