#!/bin/bash

cd /workspaces/new-repo

git switch main
git switch -c bugfix/readme

sed -i 's/Ein einfache JavaScript-Bibliothek/Eine einfache JavaScript-Bibliothek/' ./README.md

git add ./README.md
git commit -m "B1 - fix: Typo in readme"

git switch main

git branch -D bugfix/readme

echo "-------------------------------------------------------------------------"
echo "Soeben wurde der Branch bugfix/readme aus Versehen gelöscht. Er soll"
echo "wieder hergestellt werden."
echo "-------------------------------------------------------------------------"
