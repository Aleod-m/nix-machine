#!/usr/bin/env bash

job_list() {
    local list=$(jobs -r | sed -e 's/   */ /g')
    echo "$list";

    while read -r job_nb status cmd; do
        echo "nb: $job_nb"
        echo "status: $status"
        echo "cmd: $cmd"
    done<<<"$list"
}

# Argument Parsing.
while getopts "hblw:" opt; do
    case $opt in
        h) usage;
        ;;
        l) job_list; 
        ;;
        b) background=true;
        ;;
        w) path=$OPTARG
        ;;
        ?)
        ;;
        *)
    esac
done
shift $(( - 1));
