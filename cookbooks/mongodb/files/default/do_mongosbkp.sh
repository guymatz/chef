#! /bin/sh
#. ~/.bash_profile

program=`basename $0`
machine=`hostname -a`
BASEDIR=/data/db/backup
BKPFOLDER=compressed
BKPDIR=$BASEDIR/$BKPFOLDER
sdate=`date +'%Y-%m-%d:%H:%M'`
FILE="$BASEDIR/backup-$sdate.tarz"
DUMP_LOG1="$BASEDIR/backup-$sdate.log"
AGE=5
dba_email="CCRDDatabaseOperations@clearchannel.com,JosephHammerman@clearchannel.com,MichaelMoss@clearchannel.com,JeremyBraff@clearchannel.com"
#dba_email="DimitriyRoyzenberg@clearchannel.com"

echo " " > $DUMP_LOG1

echo "$(date +'%Y-%m-%d %T') Removing backups older than $AGE day(s)" >> $DUMP_LOG1
find $BASEDIR -name "backup*" -mtime +$AGE -print -exec rm {} \;  >> $DUMP_LOG1
echo " " >> $DUMP_LOG1

echo "$(date +'%Y-%m-%d %T') : Started MongoDUMP backup" >> $DUMP_LOG1
rm -rf $BKPDIR
mkdir -p $BKPDIR
echo " " >> $DUMP_LOG1
echo mongodump -o $BKPDIR >> $DUMP_LOG1
mongodump -o $BKPDIR >> $DUMP_LOG1 2>&1
res1=$?
echo $res1

cd $BASEDIR
echo " " >> $DUMP_LOG1
echo tar zcvf $FILE $BKPFOLDER >> $DUMP_LOG1
tar zcvf $FILE $BKPFOLDER >> $DUMP_LOG1 2>&1
res2=$?
echo $res2

egrep -i 'mongodump:|fatal|failed|does not exist|error|not found|unrecognized' $DUMP_LOG1
res3=$?
echo $res3

STATUS_FILE="$BASEDIR/backup.status"
if [ $res1 -ne 0 ] || [ $res2 -ne 0 ] || [ $res3 -eq 0 ]; then
   echo "Errors occurred during backup"
   subj="$machine:$program: FAILURE: MongoDB Backup!"
   echo FAILURE > $STATUS_FILE
else
   echo  "Backup succeeded."
   subj="$machine:$program: SUCCESS: MongoDB Backup!"
   echo SUCCESS > $STATUS_FILE
fi

echo " " >> $DUMP_LOG1
echo "$(date +'%Y-%m-%d %T') : Completed MongoDUMP backup" >> $DUMP_LOG1
ls -ltrh $BASEDIR/backup-$sdate* >> $DUMP_LOG1

echo $subj
mail -s "$subj" $dba_email < $DUMP_LOG1
