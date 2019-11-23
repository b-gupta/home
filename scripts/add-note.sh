#!/bin/bash
[ -z $1 ] && echo "Note name required!" && exit 1
name=$HOME/notes/$(date +"%Y-%m-%d-$1.md")
echo "Creating new note $name"
touch $name
gvim $name
