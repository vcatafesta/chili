#!/usr/bin/tclsh

if {$argc!=2} {
	puts stderr "Usage:	%s DATABASE SQL-STATEMENT"
	puts stderr "	db.tcl test.db 'select * from tbl1;'"
	exit 1
}

package require sqlite3
sqlite3 db [lindex $argv 0]
db eval [lindex $argv 1] x {
	foreach v $x(*) {
		puts "$v = $x($v)"
	}
	puts ""
}
db close
