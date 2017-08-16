#!/bin/bash

wpengineRemoteName=$1
themePath=wp-content/themes/$2
currentLocalGitBranch=`git rev-parse --abbrev-ref HEAD`


function check_theme_exists () {
  if [ ! -d $themePath ]; then
    echo -e "$themePath does not exist"
    exit 1
  fi
}

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



check_theme_exists
check_remote_exists
check_uncommited_files

git checkout -b tmp-wpe-deploy
cd $themePath
sed -i '' '/dist/d' ./.gitignore
gulp --production
git add dist
git commit -am "deploy to wpengine"
git push --force $wpengineRemoteName tmp-wpe-deploy:master
git checkout master
git branch -D tmp-wpe-deploy
cd ../../../