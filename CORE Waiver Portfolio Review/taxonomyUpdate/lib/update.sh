#!/usr/bin/env bash
# variables
today=$(date +"%Y-%m-%d")
datadir="data"
csv="${datadir}/${today}.csv"
bold="$(tput bold)"
reset="$(tput sgr0)"

# Open Informer to report
open "https://vm-informer-01.cca.edu/informer/?locale=en_US#action=ReportRun&reportId=42598401&launch=false" &

while [ ! -f "$csv" ]; do
    echo "Save the CSV from Informer to the data directory, naming it ${bold}${today}.csv${reset} (today's date)."
    echo "Make sure to ${bold}un-check 'Show Column Headers'${reset} in the Export options."
    echo "Hit return when you're done…"
    read -r
done

# Make a backup
cp "$csv" "${csv}.bak"

# Perl script for data munging
# => sort alphabetically
# => eliminate duplicate adjacent lines
perl lib/ProcessFYwaiver.pl "$csv" | sort | uniq > "${csv}.tmp"
# uniq can't edit a file in place, here we're deleting the temp file
mv -f "${csv}.tmp" "$csv"

# combine with the last run's CSV & dedupe
while [ ! -f "$priorcsv" ]; do
    echo "What was the date of the previous run? E.g. '2014-07-17'"
    read -r name
    priorcsv="${datadir}/${name}-deduped.csv"
done

cat "$priorcsv" "$csv" | sort > "${csv}.tmp"

# Dedupe script
python ./lib/dedupe.py "${csv}.tmp"
rm -f "${csv}.tmp"

echo "Enter EQUELLA username (eric1 by default):"
read -r un
[ -z "$un" ] && un="eric1"
echo "Enter EQUELLA password:"
read -rs pw

# Python script for uploading taxonomy
# It knows the date & finds the data CSV, so no need to pass a filename to it
python ./lib/UploadTaxonomy.py "$un" "$pw"
