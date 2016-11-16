declare -a problema=("xor" "digits")


for prob in "${problema[@]}"
do
	echo "problema, Media, Desv, Media, Desv, Media, Desv, Media, Desv" > CCR_comb_$prob.csv
	if [ $prob == "xor" ]
	then
		neuronas=100
		capa=2
		eta=0.1
		mu=0.9
		iter=1000
	elif [ $prob == "digits" ]
	then
		neuronas=75
		capa=1
		eta=0.7
		mu=1
		iter=300
	fi
			echo "$prob  $neuronas $capa $eta $mu $iter - Inicio"
			salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f 0)
			errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

			echo "MSE-sigmoide, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> CCR_comb_$prob.csv
			
			echo "$prob - Inicio"
			salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f 0 -s)
			errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

			echo "MSE-Softmax, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> CCR_comb_$prob.csv
			
			echo "$prob - Inicio"
			salida=$(./practica2 -t ../train_$prob.dat -T ../test_$prob.dat -i $iter -b -l $capa -h $neuronas -e $eta -m $mu -f 1 -s)
			errorTrain=$(echo $salida | sed -n -e 's/.* Error de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			errorTest=$(echo $salida | sed -n -e 's/.* Error de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTrain=$(echo $salida | sed -n -e 's/.* CCR de entrenamiento (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')
			CCRTest=$(echo $salida | sed -n -e 's/.* CCR de test (Media DT):[ \t]*\([^ \t]*\)[ \t]*\([^ \t]*\).*/\1, \2 /p')

			echo "EntropíaCruzada-sigmoide, $errorTrain, $errorTest, $CCRTrain, $CCRTest" >> CCR_comb_$prob.csv
			
			echo "$prob - Fin"
done
