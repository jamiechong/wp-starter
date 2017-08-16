#!/bin/bash

wpengineRemoteName=$1
currentLocalGitBranch=`git rev-parse --abbrev-ref HEAD`


# Check if specified remote exists
function check_remote_exists () {
  echo "Checking if specified remote exists..."
  git ls-remote "$wpengineRemoteName" &> /dev/null
  if [ "$?" -ne 0 ]; then
    echo -e "Unknown git remote \"$wpengineRemoteName\""
    echo "Available remotes:"
    git remote -v
    exit 1
  fi
}


# Halt if there are uncommitted files
function check_uncommited_files () {
  if [[ -n $(git status -s) ]]; then
    echo -e "Found uncommitted files on current branch \"$currentLocalGitBranch\".\n        Review and commit changes to continue."
    git status
    exit 1
  fi
}




check_uncommited_files
check_remote_exists

git checkout -b tmp-wpe-deploy
cd wp-content/themes/modernpet/
sed -i '' '/dist/d' ./.gitignore
gulp --production
git add dist
git commit -am "deploy to wpengine"
git push --force $wpengineRemoteName tmp-wpe-deploy:master
git checkout master
git branch -D tmp-wpe-deploy
cd ../../../