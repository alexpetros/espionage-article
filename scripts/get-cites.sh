#!/bin/bash
# Name: get-cites.sh
# Author: Alex Petros

# This is a small script to list the tags of cites in the project
# If you supply the -u argument, it will on print the unused cites

usage() { echo "Usage: get-cites [-u] [rootDir]"; exit 1; }

bibFile="article.bib"
texFile="article.tex"
unused=false

# Process options
# TODO add sort-by-year option
while getopts ":u" opt; do
    case "${opt}" in
        u) # output only unused citations
            unused=true
            ;;
        \?) 
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Get cites location
if [[ "$#" -ne 1 ]]; then
    usage
fi

# Get the citations in the .bib file
rootDir=$1
citesPath="$rootDir/$bibFile"
bibCites=$( cat "$citesPath" | grep -E '@\w+{' | sed -E 's/@.*{(.*),/\1/g' )

# If -u was not specificed then output cites
if [[ "$unused" = false ]]; then
    echo "$bibCites"
    exit 0
fi

# Otherwise process the differnce between the two
articleCites=$( cat article.tex | grep -oE '\\(foot)?cite(\[[^]]*\])?{[^}]*}' | sed -E 's/^.*{(.*)}/\1/g' | sort -u )
bibCites=$( echo "$bibCites" | sort -u )

# remove extra stuff from the div
diff <( echo "$articleCites" ) <( echo "$bibCites" ) | grep '>' | sed 's/> //'

