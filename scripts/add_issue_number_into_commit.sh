#!/bin/bash

# This hook works for branches named such as "123-description" and will add "[#123]" to the commit message.

# get current branch
branchName=`git rev-parse --abbrev-ref HEAD`

# search issue id in the branch name, such a "123-description" or "XXX-123-description"
issueId=$(echo $branchName | sed -nE 's,([A-Z]?-?[0-9]+)-.+,\1,p')

# only prepare commit message if pattern matched and issue id was found
if [[ ! -z $issueId ]]; then
 # $1 is the name of the file containing the commit message
 # We prepend issue number in the beginning (so we can easily see it in history)
 # And also we append the full issue id (with organization/repository#) prefix,
 # so this commit hook works for other repositories (frontend) too.
 echo -e "[#$issueId] ""$(cat $1)""\n[organization/repository#$issueId]" > "$1"
 # sed -i.bak -e "1s/^/\n\n[$issueId]\n/" $1
 # echo -e "[$issueId]\n""$(cat $1)" > "$1"
 # sed -i.bak -e "1s/^/$TRIMMED /" $1
fi