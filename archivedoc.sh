#!/bin/bash

while [ true ]; do
	/home/archive/archivedoc-single.sh

	zenity --question --text="Archive more documents?"

	if [ "$?" == "1" ]; then
		break;
	fi
done

