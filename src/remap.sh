FILE_NAME=$1
PREFIX=$2
NEW_PREFIX=$3

# replace delimter backslash with forward slash
EXPR="s/^.*music-lib/'${NEW_PREFIX}'/g"
TEST=xx
#FILE_CONTENTS=$(cat $FILE_NAME | sed 's/\\/\//g'  | sed ${EXPR})
FILE_CONTENTS=$(cat $FILE_NAME | sed 's/\\/\//g'  | sed s/^.*music-lib/${TEST}/g)
echo "FILE_CONTENT:$FILE_CONTENTS"
# FILE_CONTENTS=$(cat "$FILE_NAME" | sed "s/^.*music-lib/x/g")
# echo "OUT:$FILE_CONTENTS"

echo "${EXPR}"
echo "FILE_NAME_OUT=${FILE%.*}.txt"
echo "PREFIX:$PREFIX"
echo "NEW_PREFIX:$NEW_PREFIX"