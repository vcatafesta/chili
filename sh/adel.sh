#!/bin/bash
source /etc/bashrc

array=(pluto pippo bob)

echo "######################################################"
for i in "${!array[@]}"; do
	echo $i
done

delete=(pippo)
for target in "${delete[@]}"; do
  for i in "${!array[@]}"; do
    if [[ ${array[i]} = "${delete[0]}" ]]; then
      unset 'array[i]'
    fi
  done
done
echo "######################################################"

for i in "${!array[@]}"; do
	echo $i
done

# Se as lacunas forem um problema, você precisará reconstruir a matriz para preencher as lacunas:
for i in "${!array[@]}"; do
    new_array+=( "${array[i]}" )
done
array=("${new_array[@]}")
unset new_array
echo "######################################################"

for i in "${!array[@]}"; do
	echo $i   		# imprime o item da matriz
done

for item in ${array[*]}
do
	echo $item     #imprime o conteudo da matriz
done

echo "######################################################"
# removendo duplicados e ordenando
array=('um' 'dois' 'um' 'dois' 'tres')
for item in ${array[*]}
do
	echo $item
	echo $item >> /tmp/.array    #imprime o conteudo da matriz
done
unset array
echo "######################################################"
array=$(uniq --ignore-case <<< $(sort /tmp/.array))
rm ./tmp/.array
info $array
for item in ${array[*]}
do
	echo $item
done

