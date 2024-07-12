#! /bin/bash

# Example
# ./hash_list.sh ~/test/songs.m3u
# @music_shell/src >$ ./hash_list.sh ../test/songs.m3u
# 09db530afad81cb1c43ae45d0e760a93 @ albums|Pink Floyd|1983|The Final Cut||12|Not Now John.mp3
# 4d168ba0cc719f4a4db7fae36e188489 @ albums|Pink Floyd|1983|The Final Cut||07|Paranoid Eyes.mp3
# dbd0f5734e43faaae6c5f45592f2cb34 @ albums|Pink Floyd|1983|The Final Cut||13|Two Suns in the Sunset.mp3
# 7dadf41bd9aec7039614c16686501d56 @ albums|Pink Floyd|1983|The Final Cut||05|The Hero's Return.mp3
# fd70d2b1cc829d36b8c5264ea413bde6 @ albums|Pink Floyd|1983|The Final Cut||06|The Gunner's Dream.mp3
# 4acad14524b519c68d32da1540820ff9 @ albums|Pink Floyd|1983|The Final Cut||11|The Final Cut.mp3
# 3e2416d1d102f429b08007d1dda858a3 @ albums|Pink Floyd|1983|The Final Cut||02|Your Possible Pasts.mp3
# 58387f7c7b2d247163b35cc2c337c981 @ albums|Pink Floyd|1983|The Final Cut||03|One of the Few.mp3
# c476f76c997cfb0c52d3d7b22833c8e6 @ albums|Pink Floyd|1983|The Final Cut||10|Southampton Dock.mp3
# edb0bbe8593d5e9597354464f2deb3d1 @ albums|Pink Floyd|1983|The Final Cut||09|The Fletcher Memorial Home.mp3
# e027207bd0eded6836f6c1544428ba78 @ albums|Pink Floyd|1983|The Final Cut||04|When the Tigers Broke Free [Bonus Track].mp3
# 9fd5b11b4272792be4c535c9de2df816 @ albums|Pink Floyd|1983|The Final Cut||01|The Post War Dream.mp3
# ddaee3975a98a70bb98e1b4a2b29f970 @ albums|Pink Floyd|1983|The Final Cut||08|Get Your Filthy Hands off My Desert.mp3

cat "$@" | while read -r line; do
    printf %b "$(echo $line | md5sum | cut -f1 -d' ') @ $line\n"
done