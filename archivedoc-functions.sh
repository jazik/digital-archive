
function archivedoc_scan { 
	PAGE=$1
	if [ "$PAGE" == "" ]; then
		PAGE=0
	fi
	while [ true ]; do

		zenity --question --text="Scan page?"

		if [ "$?" == "1" ]; then
			break;
		fi

		RESOLUTION=`echo -e $RESOLUTIONS | zenity --list --title="Select Resolution" --column="Resolution"`
		FILENAME=$FILE-$PAGE

		zenity --info --text "Put paper into scanner!" --ellipsize --icon-name dialog-warning

		scanimage --resolution $RESOLUTION --format $FORMAT --progress > $FILENAME.$FORMAT 2> >(stdbuf -o0 -i0 tr '\r' '\n' | stdbuf -o0 -i0 sed -u -e 's/Progress: //' | zenity --progress --no-cancel --auto-close)
		echo "  - filename: $FILENAME.$FORMAT" >> $FILE.yml
		
		((PAGE++))
	done

	if [ "$PAGE" == "0" ]; then
		echo "  - none" >> $FILE.yml
	fi
}

