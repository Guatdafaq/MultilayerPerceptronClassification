#!/bin/bash
declare -a problema=("xor" "digits")


for prob in "${problema[@]}"
do
	echo "Iteración, CCR" > convergencia_CCR_$prob.csv
	
	if [ $prob == "xor" ]
	then
		neuronas=100
		capa=2
		eta=0.1
		mu=0.9
		iter=1000
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -l $capa -h $neuronas -e $eta -m $mu -b -f 0 -o | sed -n -e 's/Iteración[ \t]*\([^ \t]*\)[ \t]*CCR de entrenamiento:[ \t]*\(.*\)[ \t]*CCR de test:[ \t]*\(.*\)/\1, \2, \3/p')
	elif [ $prob == "digits" ]
	then
		neuronas=75
		capa=1
		eta=0.7
		mu=1
		iter=300
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -l $capa -h $neuronas -e $eta -m $mu -b -f 1 -s | sed -n -e 's/Iteración[ \t]*\([^ \t]*\)[ \t]*CCR de entrenamiento:[ \t]*\(.*\)[ \t]*CCR de test:[ \t]*\(.*\)/\1, \2, \3/p')
	fi
		
		

		echo "$salida" >> convergencia_CCR_$prob.csv
done




#| sed -n -e 's/Iteración[ \t]*\([^ \t]*\)[ \t]*Error de entrenamiento:[ \t]*\(.*\)/\1, \2/p')
#echo "$salida" >> convergencia_$prob.csv
