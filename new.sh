#!/bin/bash

if [ $# -eq 1 ]; then
  # $ ./new.sh atricleName
  articlename=$1
else
  # $ ./new.sh
  read -p 'Please input article name: ' articlename
fi
hugo new post/$articlename.md

# open this project wiht Atom
atom ./ && atom ./content/post/$articlename.md