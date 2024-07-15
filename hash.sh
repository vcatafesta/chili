declare -A meuhash

meuhash['ano']=2016
meuhash['mes']=08
meuhash['dia']=28

for i in dia mes ano; do
	echo 'meuhash['$i']' = ${meuhash[$i]}
done
