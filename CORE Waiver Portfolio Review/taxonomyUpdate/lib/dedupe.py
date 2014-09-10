import sys
import csv

try:
    filename = sys.argv[1]
except IndexError:
    print 'Error! No filename passed to script!'
    exit(1)

# sample row:
# "Scotia, Nova",ID,1234234,username,nscotia,admitStatus,FF,program,Fashion
# Design (BFA),startTerm,Fall 2014,currentStatus,,
students = list(csv.reader(open(filename, 'r')))
ID_INDEX = 2
UN_INDEX = 4
ids = []
dupeIds = []
new_uns = []


# merge 2 CSV rows together
def merge(row1, row2):
    out = []

    # see if one of the 2 rows is missing UN
    if row1[UN_INDEX] == "" and row2[UN_INDEX] != "":
        if row2[UN_INDEX] != "username":
            new_uns.append(row2[UN_INDEX])
    elif row1[UN_INDEX] != "" and row2[UN_INDEX] == "":
        if row1[UN_INDEX] != "username":
            new_uns.append(row1[UN_INDEX])

    for i, val in enumerate(row1):
        # if row1 doesn't have a value, take row2's value
        if val == "":
            out.append(row2[i - 1])
        else:
            out.append(val)

    # need 1 extra empty column
    out.append("")
    return out


def print_new_uns():
    if len(new_uns) > 0:
        print 'New usernames:'
        new_uns.sort()
        for un in new_uns:
            print un

# assemble a list of unique IDs
for row in students:
    id = row[ID_INDEX]
    # is the ID already in the list?
    try:
        ids.index(id)
        dupeIds.append(id)
    except ValueError:
        pass

    ids.append(id)

output = csv.writer(open(filename.replace('.csv.tmp',
                    '-deduped.csv'), 'wb'))
# loop thru again:
# 1) if first of a set of dupes, don't write to file
# 2) merge dupe with following row
# 3) write each (deduped) row to file
tempRow = None
for row in students:
    # we're on the 2nd row of a pair of dupes
    if tempRow is not None:
        output.writerow(merge(row, tempRow))
        tempRow = None
        continue

    # checking for dupes & saving to tempRow
    id = row[ID_INDEX]
    try:
        dupeIds.remove(id)
        tempRow = row
        continue
    except ValueError:
        pass

    output.writerow(row)

print_new_uns()
