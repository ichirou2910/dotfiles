#!/bin/bash

sed -i -r 's/(autohide\ \=\ )0/\11/;t;s/(autohide\ \=\ )1/\10/' ~/.config/tint2/tint2rc
killall -SIGUSR1 tint2
sed -i -r 's/(<top>)0/\145/;t;s/(<top>)45/\10/' ~/.config/openbox/rc.xml
openbox --reconfigure
sed -i -r 's/(top\=\")50/\15/;t;s/(top\=\")5/\150/' ~/.config/rtile/rtile.xml
