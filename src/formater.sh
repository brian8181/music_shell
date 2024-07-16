
ALPHA="[[:alpha:]]"
DIGIT="[[:digit:]]"

LOCATION="ALPHA*"

REGX1="\\|$ALPHA+\\|$ALPHA+\\|$DIGIT\{4\}"
REGX="$ALPHA*\|$ALPHA*\|$NUMERIC*\|"