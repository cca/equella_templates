#!/usr/bin/env bash
# variables
today=$(date +"%Y-%m-%d")
# test files are in test dir
datadir="test"
# rather than make user download report, just copy this one
cp "${datadir}/rename.csv" "${datadir}/${today}.csv"
csv="${datadir}/${today}.csv"

# this should always be true given the above
while [ ! -f "$csv" ]; do
    echo "Save the CSV from Informer to the data directory, using today's date for the name (in YYYY-MM-DD format)."
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
    echo "What is the date of the previous run's csv? For this test it's '2014-07-22'."
    read -r name
    priorcsv="${datadir}/${name}-deduped.csv"
done

cat "$priorcsv" "$csv" | sort > "${csv}.tmp"

# Dedupe script
python ./lib/dedupe.py "${csv}.tmp"
rm -f "${csv}.tmp"

# see if the test worked
testsuccess () {
    echo 'New usernames should be these:' && cat "test/results.txt"
    [ -f "${datadir}/${today}.csv.bak" ] && echo 'Success! Backup file in place.'
    [ -f "${datadir}/${today}.csv" ] && echo 'Success! Processed taxonomy in place.'
    [ -f "${datadir}/${today}-deduped.csv" ] && echo 'Success! Deduped file in place.'
}

testsuccess

cleanup () {
    rm "${datadir}/${today}.csv" "${datadir}/${today}.csv.bak" "${datadir}/${today}-deduped.csv"
}

cleanup
