#!/bin/bash

. /home/archive/archivedoc-functions.sh

RESOLUTIONS="150dpi\n300dpi\n600dpi\n"
FORMAT=jpeg
DIR=/home/archive

export LC_TIME="en_US.UTF-8"

FILE=`zenity --file-selection --file-filter="YAML | *.yml" --filename="documents/*" --title="Select document to which you want to add scan"` || exit 0
FILE=`basename $FILE`
FILE="${FILE%.*}"

if [ ! -f documents/$FILE.yml ]; then
	zenity --info --text "Document doesn't exist!"
	exit 0
fi

pushd $PWD
cd $DIR/documents

PAGE=`grep "filename: $FILE" $FILE.yml | tail -1 | sed -e "s/  - filename: ${FILE}-//" -e "s/.jpeg//"`
if [ "$PAGE" == "" ]; then
	PAGE=0
	sed -i -e '/  - none/d' $FILE.yml
else
	((PAGE++))
fi

archivedoc_scan $PAGE

popd
