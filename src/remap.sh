FILE_NAME=$1
PREFIX=$2
NEW_PREFIX=$3

# FILE_CONTENT=$(cat $FILE_NAME | sed 's/Z:\\mnt\\music\\music-lib\\//g')
# echo "FILE_CONTENT:$FILE_CONTENTS"
# replace delimter backslash with forward slash
FILE_CONTENTS=$(cat $FILE_NAME | sed 's/\\/\//g')
echo "FILE_CONTENT:$FILE_CONTENTS"

echo "FILE_NAME_OUT=${FILE%.*}.txt"

# echo $FILE_CONTENTS | "sed s/${PREFIX}/xxxx/g" > ${FILE%.*}.txt
echo "PREFIX:$PREFIX"
echo "NEW_PREFIX:$NEW_PREFIX"