#!/bin/bash

while getopts ':m:z' arg;
do
    case "$arg" in
        m)  MESSAGE=$OPTARG
            ;;
        z)  INVISIBLE='true'
            ;;
        ?)  echo '-m "commit message" file1 file2'  
            exit 2
            ;;
    esac
done
shift $(( OPTIND - 1 ))

# check input parameters
FILES="$@"
if [[ ! -n "$FILES" ]] || [[ ! -n "$MESSAGE" ]];
then
    echo 'Missing input parameters'
    echo 'Files: '"$FILES"
    echo 'Message: '"$MESSAGE"
    exit 2
fi

GITFILE='.git'
GITBACKUPFILE='.git.bck'

# start treating as a repo again
if [[ -e "$GITBACKUPFILE" ]];
then
    echo "setting back to repo"
    INVISIBLE='true'
    mv "$GITBACKUPFILE" "$GITFILE"
fi

GITREPO=$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null)
GITBRANCH=`git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p"`
echo 'Adding '"$FILES"' to '"$GITREPO"' on '"$GITBRANCH"

# add specified files
git add $FILES
git commit -m "$MESSAGE"
git push -u origin "$GITBRANCH"

# reset
if [[ $INVISIBLE = 'true' ]];
then
    echo "unsetting repo"
    mv "$GITFILE" "$GITBACKUPFILE"
fi
