#!/usr/bin/env bash

# variables
today=$(date +"%Y-%m-%d")
csv="../data/${today}.csv"

usage () {
    echo "Usage:"
    echo
    echo -e "\t./taxonomyUpdate.sh"
    echo -e "\t\tWithout any arguments, the script asks for your Informer"
    echo -e "\t\tusername and password, downloads the report to"
    echo -e "\t\tdata/YYYY-MM-DD.csv (e.g. data/2014-07-04.csv), processes"
    echo -e "\t\tthe report, then uploads the taxonomy to VAULT."
    echo
    echo -e "\t./taxonomyUpdate.sh -u username -p password -t download.csv -m"
    echo -e "\t\tRather than use a prompt or default, you can specify your"
    echo -e "\t\tlogin and the download location via parameters. The \"-m\" flag"
    echo -e "\t\tstands for \"manual\", in which case the script will merely"
    echo -e "\t\topen Informer and later prompt you for the downloaded"
    echo -e "\t\treport's location to continue processing."
    echo -e "\t\tAll arguments are optional."
    echo
    exit 0
}

if [ "$1" = "help" ]; then
    usage
fi

while getopts "u:p:t:mh" o; do
    case "${o}" in
        u)
            un=${OPTARG}
            echo "un is $un"
            ;;
        p)
            pw=${OPTARG}
            echo "pw is $pw"
            ;;
        t)
            csv=${OPTARG}
            echo "csv is $csv"
            ;;
        h)
            usage
            ;;
        m)
            manual=true
            echo "manual is $manual"
            ;;
        \?)
            echo "Didn't recognize option -$OPTARG; ignoring it."
            ;;
    esac
done

# Obtain Informer credentials
if [ "$un" = "" ]; then
    read -rs -p "Informer username (ephetteplace):" un
    echo
    echo "un is $un"

    # default to ephetteplace
    if [ ! $un ]; then
        un=ephetteplace
        echo "un is $un"
    fi
fi

# only do this step if we're not explicitly manual already
if [ "$pw" = "" -a ! "$manual" ]; then
    read -rs -p "Informer password (leave empty to manually run report):" pw
    echo

    if [ "$pw" = "" ]; then
        manual=true
        echo "manual is $manual"
    fi
fi

exit

# Python script to open Informer, login, run report, download
# INCOMPLETE
./runInformerReport.py -u "$un" -p "$pw"

# Perl script for data munging
# => sort alphabetically
# => eliminate duplicate adjacent lines
./ProcessFYwaiver.pl "$csv" | sort | uniq > "${csv}.tmp"
# uniq can't pipe to the same file it takes as input (recursion)
# so here we're just deleting the temporary file
mv -f "${csv}.tmp" "$csv"

# Python script for uploading taxonomy
