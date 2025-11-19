#!/bin/bash

cd /workspaces/new-repo

git switch feature/modulo
git rebase main

echo "-------------------------------------------------------------------------"
echo "Soeben wurde der Branch feature/modulo mit Hilfe von git rebase main"
echo "verschoben. Die Rebase-Operation soll rückgängig gemacht werden."
echo "-------------------------------------------------------------------------"
