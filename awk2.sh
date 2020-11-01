#!/usr/bin/bash

awk 'BEGIN { FS=":"; print "*** inicio ***\n" }
    {
       print $1 " => " $7
    }
	END { print "*** fim ***" }' /etc/passwd
