#!/bin/bash

month=$(date "+%m")
year=$(date "+%Y")

if [ $# -eq 1 ]; then
  # $ ./new.sh atricleName
  articlename=$1
else
  # $ ./new.sh
  read -p 'Please input article name: ' articlename
fi
hugo new post/${year}/${month}/${articlename}.md

# open this project wiht Atom
atom ./ && atom ./content/post/${year}/${month}/${articlename}.md