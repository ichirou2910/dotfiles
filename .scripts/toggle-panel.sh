#!/bin/bash

sed -i -r 's/(autohide\ \=\ )0/\11/;t;s/(autohide\ \=\ )1/\10/' ~/.config/tint2/tint2rc
killall -SIGUSR1 tint2
sed -i -r 's/(<bottom>)0/\145/;t;s/(<bottom>)45/\10/' ~/.config/openbox/rc.xml
openbox --reconfigure
sed -i -r 's/(bottom\=\")50\"/\15\"/;t;s/(bottom\=\")5\"/\150\"/' ~/.config/rtile/rtile.xml
