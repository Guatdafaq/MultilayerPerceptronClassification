#!/bin/bash
salida=$(./practica2 -t ../train_digits.dat -T ../test_digits.dat -i 300 -b -l 1 -h 75 -e 0.1 -m 1 -f 1 -s -o)
echo "Estructura, Media, Desv, Media, Desv, Media, Desv, Media, Desv" > prueba.csv
			
			errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

echo "on-line (eta bajo), $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> prueba.csv