#!/bin/bash
mpkg-update
COUNT="LC_ALL=C mpkg-listupdates | wc -l"

if [ "$COUNT" != "1" ] ; then
	notify-send "Найдены обновления: `mpkg-listupdates | tail -n +1`"
fi

