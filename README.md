# findmeta.sh - Salesforce Metadata Search Tool

This shell script (`findmeta.sh`) is designed to efficiently search for specific terms within Salesforce metadata files. It provides color-coded output based on the metadata category, making it easier to identify and navigate through the results.

## Features

* **Color-coded output:** Categorizes search results and displays them with distinct background colors for easy identification (Configuration, Code, Automation, Security, Experience, Others).
* **Case-insensitive search:** Finds matches regardless of letter casing.
* **Detailed output (optional):** Displays matching lines with line numbers when the `-d` flag is used.
* **Clear category headers:** Groups search results by metadata folder (e.g., objects, classes, flows).
* **Easy to use:** Simple command-line interface.

## Usage
``` bash
./findmeta.sh [options] <directory> <search_term>`
```

### Options:

- `-h`: Display help message and exit.
- `-d`: Enable detailed output, showing matching lines with line numbers.

### Arguments
- `<directory>`: The path to the Salesforce metadata directory.
- `<search_term>`: The term to search for within the metadata files.

#### Example
To search for the term "Account" in the `/path/to/salesforce/metadata` directory with detailed output:

``` bash
./findmeta.sh -d /path/to/salesforce/metadata Account`
```
To search for the term "MyCustomField" without details:

``` bash
./findmeta.sh /path/to/salesforce/metadata MyCustomField
```

## Color Coding
The script categorizes Salesforce metadata and applies background colors to the category headers:

- Configuration: (Blue) objects, layouts, fields, recordTypes, pages
- **Code**: (Magenta) classes, lwc, aura
- **Automation**: (Cyan) flows, workflow, approvals
- **Security**: (Yellow) profiles, permissionSets, sharingRules
- **Experience**: (Green) community, site, navigationMenus
- **Others**: (White) Any other folder.

## Prerequisites
- A Unix-like operating system (macOS, Linux, etc.).
- Bash shell.
- `find`, `grep`, `sort` utilities.

## Installation
1. Save the script as findmeta.sh.
2. Make the script executable:
``` bash
chmod +x findmeta.sh
```