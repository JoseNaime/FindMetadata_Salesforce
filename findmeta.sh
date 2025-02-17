#!/bin/bash

# Define some background colors
CONFIG_BG="\e[44m"       # Blue background
CODE_BG="\e[45m"         # Magenta background
AUTOMATION_BG="\e[46m"   # Cyan background
SECURITY_BG="\e[43m"     # Yellow background
EXPERIENCE_BG="\e[42m"   # Green background
DEFAULT_BG="\e[47m"      # White background for 'others'
RESET="\e[0m"

# Helper function: returns a background color based on folder name
getCategoryColor() {
  case "$1" in
    objects|layouts|fields|recordTypes|pages)
      echo -e "$CONFIG_BG"
      ;;
    classes|lwc|aura)
      echo -e "$CODE_BG"
      ;;
    flows|workflow|approvals)
      echo -e "$AUTOMATION_BG"
      ;;
    profiles|permissionSets|sharingRules)
      echo -e "$SECURITY_BG"
      ;;
    community|site|navigationMenus)
      echo -e "$EXPERIENCE_BG"
      ;;
    *)
      echo -e "$DEFAULT_BG"
      ;;
  esac
}

############################################################
# Search word logic
############################################################

# Validate arguments
if [ $# -lt 2 ]; then
  echo "Usage: findmeta [directory] [search_term]"
  exit 1
fi

SEARCH_DIR="$1"
SEARCH_TERM="$2"

# Keep track of the last folder name displayed to group results
last_folder=""

# Use find to list all files in the given directory, then loop through them
find "$SEARCH_DIR" -type f 2>/dev/null | sort | while read -r file; do
  # Check if file contains the search term (case-insensitive)
  if grep -qi "$SEARCH_TERM" "$file"; then

    folder=$(basename "$(dirname "$file")")
    filename=$(basename "$file")

    # Print folder name only if it's different from the last printed one
    if [ "$folder" != "$last_folder" ]; then
        colorBG=$(getCategoryColor "$folder")
        printf "${colorBG}>> ${folder}${RESET}\n"
        last_folder="$folder"
    fi

    printf "\t $filename \"$SEARCH_TERM\" \n"
  fi
done