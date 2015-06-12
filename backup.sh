source config.cfg

echo -e "MySQL Backup Script"
echo -e "========================="

if [[ $IS_SLAVE == true ]];then
	echo "Stopping Slave\n"
	mysql -u$USERNAME -p$PASSWORD -h $HOST -e 'STOP SLAVE SQL_THREAD;';
fi

echo -e "Dumping SQL and Gzipping..."
NOW=$(date +"%m-%d-%Y-%H-%M-%s")
mysqldump -u $USERNAME -p$PASSWORD -h $HOST $DB | gzip > $FOLDER/$PREFIX.$NOW.tar.gz


if [[ $IS_SLAVE == true ]]; then
echo -e 'Starting Slave...'
mysql -u$USERNAME -p$PASSWORD -h $HOST -e 'START SLAVE;';

fi

echo  -e "MySQL Backed up in $FOLDER/$PREFIX.$NOW.tar.gz"

