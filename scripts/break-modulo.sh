#!/bin/bash

cd /workspaces/new-repo

git switch feature/modulo
git reset --hard HEAD~2

git switch main

echo "-------------------------------------------------------------------------"
echo "Ein Entwickler hat im Branch feature/modulo die beiden Commits M3 und M4"
echo "gelöscht (git reset --hard ...). Diese müssen wiederhergestellt werden."
echo "-------------------------------------------------------------------------"
