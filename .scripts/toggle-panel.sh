#!/bin/bash

sed -i -r 's/(autohide\ \=\ )0/\11/;t;s/(autohide\ \=\ )1/\10/' ~/.config/tint2/tint2rc;killall -SIGUSR1 tint2
sed -i -r 's/(<top>)6/\151/;t;s/(<top>)51/\16/' ~/.config/openbox/rc.xml;openbox --reconfigure
