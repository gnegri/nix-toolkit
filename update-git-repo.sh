#!/bin/bash

while getopts ':z' arg;
do
    case "$arg" in
        z)  INVISIBLE='true'
            ;;
        ?)  echo '-z only'
            exit 2
            ;;
    esac
done
shift $(( OPTIND - 1 ))

GITFILE='.git'
GITBACKUPFILE='.git.bck'

# start treating as a repo again
if [[ -e "$GITBACKUPFILE" ]];
then
    echo "setting back to repo"
    INVISIBLE='true'
    mv "$GITBACKUPFILE" "$GITFILE"
fi

# if not a repo...
if [[ ! -e "$GITFILE" ]];
then
    echo 'Not a git repo'
    exit 2
fi

GITREPO=$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null)
GITBRANCH=`git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p"`

echo 'Updating '"$GITREPO"' on branch '"$GITBRANCH"
git pull

if [[ $INVISIBLE = 'true' ]];
then
    echo "unsetting repo"
    mv "$GITFILE" "$GITBACKUPFILE"
fi
