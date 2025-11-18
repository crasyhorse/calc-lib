#!/bin/bash

cd /workspaces/new-repo

git switch feature/modulo
git rebase main

echo "-------------------------------------------------------------------------"
echo "Soeben wurde der Branch bugfix/readme aus Versehen gelöscht. Er soll"
echo "wieder hergestellt werden."
echo "-------------------------------------------------------------------------"
