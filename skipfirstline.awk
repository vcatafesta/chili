#!/usr/bin/env awk -f

NR >=2 {print( NR " - " $0)}
