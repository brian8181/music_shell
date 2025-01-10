#! /bin/bash

# Example

# music_shell/src >$ ./hash_items_sha1.sh ../test/songs.m3u
# 3b5737bdaf5f47083907e5f46fe32b91c607b5a4 @ albums|Pink Floyd|1983|The Final Cut||12|Not Now John.mp3
# d464a60a74512063579e30bba24d991e072ea061 @ albums|Pink Floyd|1983|The Final Cut||07|Paranoid Eyes.mp3
# 82df0b7f31947b26a266abd7a324b1ec7628f2cb @ albums|Pink Floyd|1983|The Final Cut||13|Two Suns in the Sunset.mp3
# 32a4c8f1e13e2a4e3ef3849fcb7b7bdde73ec34f @ albums|Pink Floyd|1983|The Final Cut||05|The Hero's Return.mp3
# 4f97a4c904244d18a893ef104de481fc01cbeed4 @ albums|Pink Floyd|1983|The Final Cut||06|The Gunner's Dream.mp3
# 0cddf4ad5889a6417654b80010dd566a0f0ffec4 @ albums|Pink Floyd|1983|The Final Cut||11|The Final Cut.mp3
# 48a4b0278c15d0912a771a878f6e1da1da7204f7 @ albums|Pink Floyd|1983|The Final Cut||02|Your Possible Pasts.mp3
# ffb8770a5d3bb042724440a0eee8182f708f205b @ albums|Pink Floyd|1983|The Final Cut||03|One of the Few.mp3
# 638238d0ad72d2f7266bc0f73608dd9e837d1f8f @ albums|Pink Floyd|1983|The Final Cut||10|Southampton Dock.mp3
# 47143d85cba7117a3c99278834ce58430997211e @ albums|Pink Floyd|1983|The Final Cut||09|The Fletcher Memorial Home.mp3
# 026bd99d177fc27b6fe427112a46d91c96e83975 @ albums|Pink Floyd|1983|The Final Cut||04|When the Tigers Broke Free [Bonus Track].mp3
# 5965532767fcce7b7d06acb85168f7c2bf852d8d @ albums|Pink Floyd|1983|The Final Cut||01|The Post War Dream.mp3
# 2fbc3de4ad72be8b23d5edc58695763359ff8a56 @ albums|Pink Floyd|1983|The Final Cut||08|Get Your Filthy Hands off My Desert.mp3

cat "$@" | while read -r line; do
    printf %b "$(echo $line | sha1sum | cut -f1 -d' ') @ $line\n"
done