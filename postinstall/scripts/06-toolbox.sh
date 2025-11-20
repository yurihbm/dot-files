#!/bin/bash

echo -e "\nSetting up Toolbox environment template..."

TOOLBOX_TEMPLATE_FOLDER="$HOME/.toolbox-env/_template"

mkdir -p "$TOOLBOX_TEMPLATE_FOLDER"

cp -r ../toolbox/* "$TOOLBOX_TEMPLATE_FOLDER"

echo -e "\nToolbox environment template setup complete.\n"
