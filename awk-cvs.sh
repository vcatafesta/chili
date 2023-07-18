#!/bin/bash
source /usr/share/fetch/core.sh

#awk '{
#			FS=",";
#			split($4,array," ");
#			print NR, $4
#			print array[1]
#		}' /var/cache/fetch/search/packages-installed-split.csv

awk '{
			FS=",";
			for(i=0; ++i <= NF;){
				print NR, $4
			}
 		}' /var/cache/fetch/search/packages-installed-split.csv


 awk -F\| '{
  for (i = 0; ++i <= NF;)
    print i, $i
  }' <<<'12|23|11'
#info "${array[*]}"

echo "12|23|11" | awk '{split($0,a,"|"); print a[3] a[2] a[1]}'

sudo df -k | awk 'NR>1' | while read -r line; do
   #convert into array:
   array=($line)

   #variables:
   filesystem="${array[0]}"
   size="${array[1]}"
   capacity="${array[4]}"
   mountpoint="${array[5]}"
   echo "filesystem:$filesystem|size:$size|capacity:$capacity|mountpoint:$mountpoint"
done

info "${filesystem[*]}"
