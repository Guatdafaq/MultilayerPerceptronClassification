declare -a problema=("xor" "digits")


for prob in "${problema[@]}"
do
	echo "Versión, Media, Desv, Media, Desv, Media, Desv, Media, Desv" > on_off_comp_$prob.csv
	if [ $prob == "xor" ]
	then
		neuronas=100
		capa=2
		eta=0.1
		mu=0.9
		iter=1000
		error=0
		echo "$prob  $neuronas $capa $eta $mu $iter - Inicio"
		echo "offline"
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f $error)
		errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

		echo "off-line, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> on_off_comp_$prob.csv
			
		echo "$prob - Inicio"
		echo "online"
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f $error -o)
		errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

		echo "on-line, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> on_off_comp_$prob.csv

	elif [ $prob == "digits" ]
	then
		neuronas=75
		capa=1
		eta=0.7
		mu=1
		iter=300
		error=1
		echo "$prob  $neuronas $capa $eta $mu $iter - Inicio"
		echo "offline"
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f $error -s)
		errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

		echo "off-line, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> on_off_comp_$prob.csv
			
		echo "$prob - Inicio"
		echo "online"
		salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f $error -s -o)
		errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
		CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

		echo "on-line, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> on_off_comp_$prob.csv
	
			
		echo "$prob - Fin"
	fi

done