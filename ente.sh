#!/bin/bash

rm -f aur.db

sqlite3 aur.db "CREATE TABLE aur (ID INTEGER, Name TEXT, PackageBaseID INTEGER, PackageBase TEXT, Version TEXT, Description TEXT, URL TEXT, NumVotes INTEGER, Popularity REAL, OutOfDate INTEGER, Maintainer TEXT, Submitter TEXT, FirstSubmitted INTEGER, LastModified INTEGER, URLPath TEXT, Depends TEXT, MakeDepends TEXT, License TEXT, Keywords TEXT);"

jq -r '.[] | [.ID, .Name, .PackageBaseID, .PackageBase, .Version, .Description, .URL, .NumVotes, .Popularity, .OutOfDate, .Maintainer, .Submitter, .FirstSubmitted, .LastModified, .URLPath, (if .Depends then (.Depends | join(";")) else "" end), (if .MakeDepends then (.MakeDepends | join(";")) else "" end), (if .License then (.License | join(";")) else "" end), (if .Keywords then (.Keywords | join(";")) else "" end)] | @csv' /var/tmp/pamac/packages-meta-ext-v1.json |
sqlite3 aur.db ".mode csv" ".import /dev/stdin aur"
