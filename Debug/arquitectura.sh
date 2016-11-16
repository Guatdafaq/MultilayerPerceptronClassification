#!/bin/bash
declare -a problema=("digits")


for prob in "${problema[@]}"
do
	echo "Estructura, Media, Desv, Media, Desv, Media, Desv, Media, Desv" > CCR_$prob.csv
	for capa in 1 2
	do
		for neuronas in  5 10 50 75
		do
			echo "Capa $capa - Neuronas $neuronas - Inicio"
			salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i 300 -b -l $capa -h $neuronas -e 0.7 -m 1 -f 1 -s)
			errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

			if [ $capa -eq 1 ]
			then
				echo "{n : $neuronas : k}, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> CCR_$prob.csv
			else
				echo "{n : $neuronas : $neuronas : k}, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> CCR_$prob.csv
			fi
			echo "Capa $capa - Neuronas $neuronas - Fin"
		done
	done
done