[ -z $1 ] && echo "Note name required!" && exit 1
name=$(date +"%Y-%m-%d-$1.md")
echo "Creating new note $name"
touch $name
vim $name
