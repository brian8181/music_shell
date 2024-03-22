#!/bin/bash
INPUT=$1
./utility/fields.sh

NAME=$($2)



# take col add piviot delimiter save to default formated name
cut -d'|' -f$NAME $INPUT | xargs | sed "s/ /|/g" > $NAME