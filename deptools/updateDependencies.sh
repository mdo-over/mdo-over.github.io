#!/bin/sh
#
# Uses CBIaggregator (https://wiki.eclipse.org/CBI/aggregator) to fetch 
# dependencies only available as p2 bundles and creates a hybrid m2/p2 
# repository (m2repo) offering mavenized versions of these dependencies.

SRC="tempRepo/final"
DST="../m2repo"
LISTFILE=$DST"/deplist.txt"

# Download dependencies to a temporary repo
echo "..downloading specified dependencies.."
./cbiAggr/runCBIaggr aggregate --buildModel="./dependencies.aggr"  --action="CLEAN_BUILD"

# Remove all dependencies copied to m2Repo in an ealier run but keep other files in m2Repo (e.g., the deployed artifact)
echo "..removing old dependencies in m2repo.."
if [ -f $LISTFILE ]; then
 while IFS= read -r OLDFILE || [ -n "${OLDFILE}" ]; do
  rm $DST$OLDFILE
 done < $LISTFILE
 rm $LISTFILE
 find $DST -type d -empty -delete
fi

# Move all dependencies to m2Repo
echo "..moving updated dependencies to m2repo.."
mkdir -p $DST
> $LISTFILE
for FILE in $(find $SRC -type f)
do
 FILEPATH=${FILE#$SRC}
 echo $FILEPATH >> $LISTFILE
 mkdir -p $(dirname $DST$FILEPATH)
 cp $FILE $DST$FILEPATH
done

# Remove the temporary repo
rm -R "tempRepo"