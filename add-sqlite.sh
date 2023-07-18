#!/usr/bin/env bash

db="example.db"
table="people"
! [[ -e $db ]] && sqlite3 "$db" "CREATE TABLE $table(fname TEXT,lname TEXT,telefone TEXT)"

echo "=======Welcome====="
echo -n "Nome      : "
read fname
echo -n "Sobrenome : "
read lname
echo -n "Telefone  : "
read telefone
echo "=======Welcome====="

sqlite3 "$db" 'PRAGMA table_info('$table')'
sqlite3 "$db" "INSERT INTO $table VALUES  ('$fname', '$lname','$telefone')"
echo
sqlite3 "$db" "SELECT * FROM people"
echo
sqlite3 "$db" "SELECT rowid, fname,lname,telefone FROM people"

