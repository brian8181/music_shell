FILE=$1
PREFIX=$2
NEW_PREFIX=$3

echo $(cat $FILE | sed 's/Z:\\mnt\\music\\music-lib\\//g')
# replace delimter backslash with forward slash
FILE_CONTENTS=$(cat $FILE | sed 's/\\/\//g')
echo $FILE_CONTENTS
echo "${FILE%.*}.txt"

# echo $FILE_CONTENTS | "sed s/${PREFIX}/xxxx/g" > ${FILE%.*}.txt
echo "PREFIX:$PREFIX"
echo "NEW_PREFIX:$NEW_PREFIX"