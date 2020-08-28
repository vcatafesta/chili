valor=123,45
valor=$(printf '%15s\n' $valor)
tr " " "#" <<< "$valor"
#########123,45


valor=123,45
tr " " "#" <<< $(printf '%15s\n' $valor)
#########123,45


tr " " "#" <<< $(printf '%15s\n' 123,45)
#########123,45


valor=123,45
printf -v valor "%15s\n" $valor
tr " " "#" <<< "$valor"
#########123,45


valor=123,45
printf -v valor "%15s" $valor
printf "%s" ${valor// /#}
#########123,45



