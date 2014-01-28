#!/bin/bash

usage() {
    echo "USAGE: live-git-index-all.sh [-c]"
    echo "   -c: [optional] show objects of the current branch"
    echo "       Do not use it to display objects of all branches"
    exit 1
}

current=

while getopts ":c" option; do
    case "${option}" in
        c)
            current=1 ;;
        *)
            usage ;;
    esac
done
shift $((OPTIND-1))

while :
do
    clear
    echo "Current Branch with Staged Content:"
    echo "$( git ls-files -s )"
    echo ""

    if [ -n "$current" ]; then
        while read branch ; do
            echo "${branch}:"
            echo "$( git ls-tree -r $branch )"
            echo ""
        done < <( git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' )
    fi
    sleep 1
done