#!/bin/bash

<<comment
Script Name: cleanup_merged_branches.sh
Author: Nidesh
Version: V1

Purpose & usage: Script to delete local branches that have already 
been merged into the main.It helps keep the local repo 
clean by removing old branches that are no long needed
comment

#variable to check current branch status
current_branch=$(git branch --show-current)

#If current branch is not main branch then exit from the script

if [[ $current_branch != main ]]; then
echo "You are not in main branch,please checkout to main branch"
exit 1
else
echo "You are in Main branch! Let's continue"
fi

echo "Finding Merged branches in Local repo"
#variable 
merged_branch=$(git branch --merged main | grep -v '\*' | grep -v main)

if [[ -z $"merged_branch" ]]; then
echo "No Merged branches found to delete"
exit 0
fi

echo "Found Merged branches: $merged_branch"

for branch in $merged_branch; do
read -p "Do you want to delete local branch: $branch (y/n): " ans

if [[ $ans == y || $ans == Y ]]; then
git branch -d $branch >/dev/null 2>&1 || git branch -D $branch 
echo "Deleted local branch: $branch "
else
echo " Skipped local branch : $branch"
fi
done

