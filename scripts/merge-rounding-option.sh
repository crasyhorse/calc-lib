#!/bin/bash

cd /workspaces/new-repo

git switch main
git merge feature/rounding-option

echo "-------------------------------------------------------------------------"
echo "Soeben wurde der Branch feature/rounding-option nach main gemerged. Dies"
echo "soll rückgängig gemacht werden."
echo "-------------------------------------------------------------------------"
