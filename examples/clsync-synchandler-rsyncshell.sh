#!/bin/sh -x

FROM="$PWD"
TO="$PWD/../to"

ACTION="$1"
LABEL="$2"
ARG0="$3"
ARG1="$4"

rsynclist() {
	LISTFILE="$1"
	EXCLISTFILE="$2"

	excludefrom=''
	if [ "$EXCLISTFILE" != "" ]; then
		excludefrom="--exclude-from=${EXCLISTFILE}"
	fi

	exec rsync -avH --delete-before "$excludefrom" --include-from="${LISTFILE}" --exclude='*' "$FROM"/ "$TO"/
}

case "$ACTION" in
	rsynclist)
		rsynclist "$ARG0" "$ARG1"
		;;
esac

