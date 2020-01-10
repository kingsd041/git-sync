#!/bin/sh

set -e

SOURCE_REPO=$1
DESTINATION_REPO=$2
BRANCH_NAME=$(echo $* | cut -d ' ' -f 3-)

echo "$BRANCH_NAME"


if ! echo $SOURCE_REPO | grep '.git'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    SOURCE_REPO="git@github.com:${SOURCE_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    SOURCE_REPO="https://github.com/${SOURCE_REPO}.git"
  fi
fi
if ! echo $DESTINATION_REPO | grep '.git'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    DESTINATION_REPO="git@github.com:${DESTINATION_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    DESTINATION_REPO="https://github.com/${DESTINATION_REPO}.git"
  fi
fi


git clone "$SOURCE_REPO" --origin source && cd `basename "$SOURCE_REPO" .git`
git remote add destination "$DESTINATION_REPO"

for BRANCH in $BRANCH_NAME
do
  echo "SOURCE=$SOURCE_REPO:$BRANCH"
  echo "DESTINATION=$DESTINATION_REPO:$BRANCH"

  git checkout $BRANCH 
  git push destination $BRANCH -f
done

git push destination --tags
