#!/bin/sh
sqlite3 test.db <<EOF
create table if not exists n (id INTEGER PRIMARY KEY,f TEXT,l TEXT);
insert into n (f,l) values ('john','smith');
select * from n;
EOF

sqlite3 -batch test.db "create table if not exists n (id INTEGER PRIMARY KEY,f TEXT,l TEXT);"
sqlite3 -batch test.db "insert into n (f,l) values ('john','smith');"
sqlite3 -batch test.db "select * from n;"

sqlite3 test.db  "create table if not exists n (id INTEGER PRIMARY KEY,f TEXT,l TEXT);"
sqlite3 test.db  "insert into n (f,l) values ('john','smith');"
sqlite3 test.db  "select * from n";

sqlite3 mydatabase.sqlite "CREATE TABLE if not exists person ( id int, name varchar(30), phone varchar(30) );"
sqlite3 mydatabase.sqlite "INSERT INTO person VALUES (1, 'Jim', '123446223');\
INSERT INTO person VALUES (2, 'Tom', '232124303');\
INSERT INTO person VALUES (3, 'Bill', '812947283');\
INSERT INTO person VALUES (4, 'Alice', '351246233');"

sqlite3 mydatabase.sqlite "SELECT name from person where id=3;"
sqlite3 mydatabase.sqlite "SELECT name from person where id=$1;"
sqlite3 mydatabase.sqlite "SELECT id from person where name='$1';"

temp=`cat file_with_temperature_value`
echo "INSERT INTO readings (TStamp, reading) VALUES (datetime(), '$temp');" | sqlite3 mydb
temp=`cat file_with_temperature_value`
sqlite3 mydb "INSERT INTO readings (TStamp, reading) VALUES (datetime(), '$temp');"

urls="$(
  sqlite3 /home/pi/.newsbeuter/cache.db \
    'select url from rss_item where unread = 1 limit 5' \
)"
for url in $urls; do
  sqlite3 /home/pi/.newsbeuter/cache.db \
    "UPDATE rss_item set unread = 0 where url = '$url'"
done

result=$(sqlite3 /media/0CBA-1996/logfiles/SQLite3Database/myDB.db "SELECT energy FROM SmartMeter WHERE Timestamp= date('now') LIMIT 1")
echo $result
result=`sqlite3 /media/0CBA-1996/logfiles/SQLite3Database/myDB.db "SELECT energy FROM SmartMeter WHERE Timestamp= date('now') LIMIT 1" `
echo $result

sqlite3 script.db "insert into notes (note) values (\"Stuff happens.\"||\"$Str1\");"
sqlite3 script.db "insert into notes (note) values ('Stuff happens.$Str1');"


 files=( $( cat list.txt ) )
  for file in "${files[@]}"
    do echo "Checking if item ${files[$count]} was already downloaded.."
	exists=$(sqlite3 sync.db "select count(*) from rememberedFiles where filename="?${files[$count]}"")
	if [ $exists > 0 ]
	then
	  echo "It exists!"
	else
	  echo "It doesn't exist!"
    fi	  
    ((count++))
  done

