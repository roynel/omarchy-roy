#!/bin/bash

# Line to add to ~/.bashrc
SOURCE_LINE="source ~/.local/share/omarchy-roy/src/bashrc"

# Check if ~/.bashrc exists
if [ ! -f ~/.bashrc ]; then
    echo "~/.bashrc does not exist. Creating it..."
    touch ~/.bashrc
fi

# Check if the line already exists in ~/.bashrc
if grep -qF "$SOURCE_LINE" ~/.bashrc; then
    echo "The line '$SOURCE_LINE' has already been added to ~/.bashrc"
else
    echo "Adding '$SOURCE_LINE' to ~/.bashrc..."
    echo "" >> ~/.bashrc
    echo "$SOURCE_LINE" >> ~/.bashrc
    echo "Successfully added to ~/.bashrc"
fi
