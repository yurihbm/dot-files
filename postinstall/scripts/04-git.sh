#!/bin/bash

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor "nvim"
git config --global push.autoSetupRemote true
