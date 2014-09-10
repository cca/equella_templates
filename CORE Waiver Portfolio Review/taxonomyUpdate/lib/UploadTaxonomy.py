# -*- coding: utf-8
# UploadTaxonomy.py
# Author: Jim Kurian, Pearson
# Date: November 15, 2012
#
# This script populates a taxonomy in EQUELLA 4.1 and higher.
# It requires Python 2.7.
#
# USAGE:
# It requires a CSV file to be formatted as follows:
#
# term0\term00\term000
# term0\term00\term001
# term1
# term1\term10
# term1\term11
# etc...
#
# If keys are required then following format should be used:
#
# term0\term00\term000, key1,      value1, key2, value2, key3, value3
# term0\term00\term001, key1,      value1,     ,       ,     ,
# term1               , key1,      value1, key2, value2,     ,
# term1\term10        , LONG_DATA, value1, key2, value2,     ,
# term1\term11        , LONG_DATA, value1,     ,       ,     ,
# etc...
#
# Any number of key/value pairs can be added to each row however
# each row of the csv must have the same number of columns. Value
# fields with commas or quotes in them should be surrounded by
# double quotes. MS Excel does this for you automatically.
# Use the key "LONG_DATA" to add a HTML Fragments to a term for
# display in the pop-view view of the term selector control.
# Set the EQUELLA connection settings in settings.py and the
# location of the CSV file and the taxonomy ID in the variables
# below.
#
# NOTE:
# This script requires the deleteTerm() method to be implemented
# in equellaSoap.py module. This function is not present in the
# equellaSoap.py module in the integration pack that ships with
# EQUELLA 5.0 or earlier. Use the module provided with this
# script.

import csv, codecs, cgi
import sys, traceback
import time
import equellasoap
import os

today = time.strftime('%Y-%m-%d', time.localtime())
csvFileName = r'data/' + today + r'-deduped.csv' # relative path to CSV file to load

if not os.path.isfile(csvFileName):
    print 'Error! Unable to find file at the given location:', csvFileName
    exit(1)

## ---- SETTINGS ---- ##

# EQUELLA parameters
institutionUrl = 'https://vault.cca.edu'
username = sys.argv[1]
# handle password with spaces in it…
password = "".join(sys.argv[2:])

# taxonomy settings
encoding = "utf-8"      # CSV unicode encoding, typically "utf-8" or "latin1" (Excel often saves non-Ascii CSV files as "latin1")
taxonID = "80ba3fde-2424-42f2-9169-80c921dbabe5"   # id of taxonomy to update (retrieve from Admin Console)
clearTaxonomy = True    # set clearTaxonomy to True if taxonomy is to be cleared first
startRow = 1            # which row in the CSV to start processing at (use 1 to process entire CSV)
unlockOnly = False      # set to true to only unlock taxonomy (no uploading)
clearOnly = False       # set to true to only clear taxonomy (no uploading)
retryOnError = False    # set to true to cause script to retry on error (useful for poor network connections)

# optional EQUELLA parameters:
proxyUrl = None
useTokens = False
tokenUser = 'tokenUsername'
sharedSecretId = 'tokenSecretId'
sharedSecretValue = 'tokenSecretValue'

## --- END SETTINGS --- ##

def unicode_csv_reader(utf8_data, encoding, dialect=csv.excel, **kwargs):
        csv_reader = csv.reader(utf8_data, dialect=dialect, **kwargs)
        firstRow = True
        for row in csv_reader:
            # remove BOM for utf-8
            if firstRow:
                if row[0].startswith(codecs.BOM_UTF8):
                    row[0] = row[0].decode("utf-8")[1:]
                firstRow = False

            yield [cell.decode(encoding) for cell in row]


if not institutionUrl.endswith("/"):
        institutionUrl += "/"
# test logging in and logging out of EQUELLA
equella = equellasoap.EquellaSoap(institutionUrl, username, password, proxyUrl)
equella.logout()
# test unlocking taxonomy
try:
        equella.unlockTaxonomy(taxonID, force=1)
except:
        raise "Unable to unlock taxonomy, check taxonomy ID"
# test opening and closing CSV
csvFile = open(csvFileName, "rb")
csvFile.close()

rownum = 0
lastAttemptedRow = 0
lastAttemptedTerm = ""
incomplete = True
retrying = False
while incomplete:
        try:

                # instantiate an EquellaSoap object and lock the taxonomy for editing
                print "Logging into EQUELLA..."
                equella = equellasoap.EquellaSoap(institutionUrl, username, password, proxyUrl)
                equella.unlockTaxonomy(taxonID, force=1)
                if unlockOnly:
                        print "Taxonomy successfully unlocked."
                        sys.exit("Unlock taxonomy only")

                print "Locking taxonomy for editing..."
                equella.lockTaxonomyForEditing(taxonID)

                # clear the taxonomy in EQUELLA
                if clearTaxonomy or clearOnly:
                        print "Clearing taxonomy..."
                        rootTerms = equella.listTerms(taxonID, "")
                        for rootTerm in rootTerms:
                                equella.deleteTerm(taxonID, rootTerm)
                        if clearOnly:
                                print "Taxonomy successfully cleared."
                                sys.exit("Clear taxonomy only")

                # read CSV file
                print "Importing taxonomy from CSV starting from row %s..." % (startRow)
                csvFile = open(csvFileName, "rb")
                reader = csv.reader(csvFile, dialect=csv.excel)

                # get row count
                rowcount = len(list(reader))
                csvFile.close()
                csvFile = open(csvFileName, "rbU")
                reader = unicode_csv_reader(csvFile, encoding)

                # remove last term in case it was only partially completed
                if lastAttemptedRow > 0:
                        try:
                                if len(equella.listTerms(taxonID, lastAttemptedTerm)) == 0:
                                        print "Deleting " + lastAttemptedTerm + " to reimport..."
                                        equella.deleteTerm(taxonID, lastAttemptedTerm)
                        except:
                                pass

                # iterate through csv rows
                for row in reader:
                        rownum += 1
                        if rownum >= startRow:

                                lastAttemptedRow = rownum

                                print "\nProcessing row %s of %s" % (rownum, rowcount)
                                terms = row[0].split("\\")
                                parentTerm = ""
                                # iterate through terms of path
                                termsAdded = False
                                for i in range(0, len(terms)):
                                        term = terms[i].strip()

                                        fullTermPath = ""
                                        if parentTerm =="":
                                                fullTermPath = term
                                        else:
                                                fullTermPath = parentTerm + "\\" + term

                                        lastAttemptedTerm = fullTermPath

                                        # if term deosn't exist add it
                                        siblingTerms = equella.listTerms(taxonID, parentTerm)
                                        if not term in siblingTerms:

                                                termsAdded = True
                                                print "  adding " + fullTermPath
                                                equella.insertTerm(taxonID, parentTerm, term)
                                                # Add data to term if it is a leaf node
                                                for j in range(1, len(row), 2):
                                                        key = row[j].strip()
                                                        if i == len(terms) - 1 and key != "":
                                                                print "    adding data key: " + key
                                                                equella.setTermData(taxonID, fullTermPath, key, row[j + 1].strip())

                                        # set current term as parent for next row (i.e. term) in the CSV
                                        parentTerm = fullTermPath


                                if not termsAdded:
                                        print "  no new terms to be added"

                incomplete = False

        except:
                exceptionType, exceptionValue, exceptionTraceback = sys.exc_info()
                error = ''.join(traceback.format_exception(exceptionType, exceptionValue, exceptionTraceback))
                if "Clear taxonomy only" in error or "Unlock taxonomy only" in error:
                        incomplete = False
                elif retryOnError:
                        # retry
                        print "\nError occured: " + str(exceptionValue)
                        print "  Last Attempted Term: " + lastAttemptedTerm
                        print "  Last Attempted Row: " + str(lastAttemptedRow)
                        print "  Retrying..."
                        time.sleep(2)

                        clearTaxonomy = False
                        startRow = lastAttemptedRow
                        rownum = 0
                else:
                        raise Exception, error


#unlock the taxonomy, logout of EQUELLA and close the csv file
equella.unlockTaxonomy(taxonID)
equella.logout()
if not clearOnly and not unlockOnly:
        csvFile.close()

print "-- PROCESSING COMPLETE --"
