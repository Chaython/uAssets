#!/usr/bin/env bash
#
# This script assumes a linux environment

set -e

DES=$(mktemp -d)
echo "*** Created temporary directory: $DES"

echo "*** Copying files to $DES"
cp ./filters/*.txt $DES/
echo "*** Checking out gh-pages"
git fetch origin gh-pages --depth=1
git checkout origin/gh-pages
echo "*** Copying files to gh-pages"
cp $DES/*.txt ./
if [[ -n $(git diff) ]]; then
  echo "*** Committing changes to gh-pages"
  git add -u
  git commit -m 'Update all lists'
  git push origin gh-pages
else
  echo "*** No changes to commit"
fi

echo "*** Removing temporary directory"
rm -f $DES/*.txt
rmdir $DES

echo "*** Checking out master"
git checkout master
