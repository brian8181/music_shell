#!/bin/bash

LIST=$1
echo $1 | sed -E 's/^([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|([[:alnum:] ]*)\|<loc>\1<\/loc>\<artist>\2<artist><date>\3<\/date><album>\4<\/album><disc>\5<\/disc><track>\6<\/track><title>\7\<\/title><ext>\8\<\/ext>/g'
