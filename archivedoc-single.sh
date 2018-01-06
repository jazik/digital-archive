#!/bin/bash

. /home/archive/archivedoc-functions.sh

RESOLUTIONS="150dpi\n300dpi\n600dpi\n"
FORMAT=jpeg
DIR=/home/archive

export LC_TIME="en_US.UTF-8"

TITLE=`zenity --entry --title="Receipt description"` || exit 0 
TITLE=`echo $TITLE | sed -e "s/[[:space:]]\+/-/g"`
DATE=`zenity --calendar --text="Select Receipt Date" --date-format=%Y-%m-%d` || exit 0
FILE="${DATE}_${TITLE}"

if [ -f documents/$FILE.yml ]; then
	zenity --info --text "Document with same date and title already exist. Use different title."
	exit 0
fi

TAGS=`cat $DIR/tags | zenity --list --title="Select Tags" --column=Tags --multiple --height=400` || exit 0 
TAGS=`echo $TAGS | sed -e 's/|/, /g'`
TEXT=`zenity --text-info --editable --title="Notes"` || exit 0 
TEXT=`echo "$TEXT" | sed -e 's/^/  /'`
CRE_DATE=`date -Iminutes`
CRE_USER=`whoami`

pushd $PWD
cd $DIR/documents

cat > $FILE.yml << EOF
---
title       : $TITLE
date        : $DATE
tags        : [$TAGS]
created-by  : $CRE_USER
created-date: $CRE_DATE
notes: |
$TEXT
documents:
EOF

archivedoc_scan

popd
