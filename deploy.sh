#!/bin/bash

echo -e "\033[0;32mBuilding sites with hugo...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

echo -e "\033[0;32mDeploying public directory to GitHub...\033[0m"

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

echo -e "\033[0;32mCommiting project repository to GitHub...\033[0m"

# Come Back up to the Project Root
cd ..

# Commit hugo project
git add .
git commit -m "$msg"
git push origin master
