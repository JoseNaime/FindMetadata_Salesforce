#!/bin/bash

# Define some background colors
CONFIG_BG="\e[44m"       # Blue background
CODE_BG="\e[45m"         # Magenta background
AUTOMATION_BG="\e[46m"   # Cyan background
SECURITY_BG="\e[43m"     # Yellow background
EXPERIENCE_BG="\e[42m"   # Green background
DEFAULT_BG="\e[47m"      # White background for 'others'
RESET="\e[0m"

# Helper functions
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

usage() {
  cat << 'EOF'
Usage: findmeta [options] <directory> <search_term>

Options:
  -h       Display this help message and exit.
  -d       Enable details on findings.

Example:
  ./findmeta.sh -d /path/to/directory search_term
EOF
}

############################################################
# Capture flags
############################################################
flag_details=false

while getopts "h|d" opt; do
  case "$opt" in
    h)
      usage
      exit 0
      ;;
    d)
      echo "Detected flag -d"
      flag_details=true
      ;;
    *)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Shift away the processed options
shift $((OPTIND - 1))

############################################################
# Search word logic
############################################################

if [ $# -lt 2 ]; then
  echo "Usage: findmeta [options] <directory> <search_term>"
  exit 1
fi

SEARCH_DIR="$1"
SEARCH_TERM="$2"

last_folder=""

find "$SEARCH_DIR" -type f 2>/dev/null | sort | while read -r file; do
  # Check if file contains the search term (case-insensitive)
 if grep -qi "$SEARCH_TERM" "$file"; then
    folder=$(basename "$(dirname "$file")")
    filename=$(basename "$file")

    if [ "$folder" != "$last_folder" ]; then
        colorBG=$(getCategoryColor "$folder")
        printf "${colorBG}>> ${folder}${RESET}\n"
        last_folder="$folder"
    fi

    printf "\t $filename \n"

    # Print matching lines with line numbers
    if [ "$flag_details" = true ]; then
      grep -in --color=always "$SEARCH_TERM" "$file" | while read -r line; do
        printf "\t\t%s\n" "$line"
      done

    fi
  fi
done

