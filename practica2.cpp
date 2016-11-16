//============================================================================
// Introducción a los Modelos Computacionales
// Name        : practica1.cpp
// Author      : Pedro A. Gutiérrez
// Version     :
// Copyright   : Universidad de Córdoba
//============================================================================

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <iostream>
#include <ctime>    // Para cojer la hora time()
#include <cstdlib>  // Para establecer la semilla srand() y generar números aleatorios rand()
#include <string.h>
#include <math.h>
#include "imc/PerceptronMulticapa.h"

using namespace imc;
using namespace std;

int main(int argc, char **argv) {

	bool tflag = 0, Tflag=0, bflag=0, oflag=0, sflag=0;
		char *tvalue = NULL, *Tvalue = NULL;
		int iteraciones=1000, hvalue=5, numCapas=1, fvalue=0;
		float eta=0.1, mu=0.9;

		int opcion;
		while ((opcion = getopt (argc, argv, "t:T:i:l:h:e:m:bof:s")) != -1){
			switch (opcion){

			// Leer fichero de train y de test desde la línea de comandos
			case 't':
				tvalue = optarg;
				tflag = 1;
				break;

			case 'T':
				Tvalue = optarg;
				Tflag = 1;
				break;
			// Leer iteraciones, capas y neuronas desde la línea de comandos
			case 'i':
				iteraciones = atoi(optarg);
				break;

			case 'l':
				numCapas = atoi(optarg);
				break;

			case 'h':
				hvalue = atoi(optarg);
				break;

			// Leer sesgo, eta y mu de la línea desde comandos
			case 'e':
				eta = atof(optarg);
				break;

			case 'm':
				mu = atof(optarg);
				break;

			case 'b':
				bflag = 1;
				break;
			// Leer tipo de error (0 MSE, 1 Entropía cruzada) de la línea de comandos
			case 'o':
				oflag = 1;
				break;

			case 'f':
				fvalue=atoi(optarg);
				break;

			case 's':
				sflag = 1;
				break;



			if (isprint (optopt))
				cerr << "Error: Opción desconocida \'" << optopt
				<< "\'" << std::endl;
			else
				cerr << "Error: Caracter de opcion desconocido \'x" << std::hex << optopt
				<< "\'" << std::endl;
			exit (EXIT_FAILURE);

			// en cualquier otro caso lo consideramos error grave y salimos
			default:
				cerr << "Error: línea de comandos errónea." << std::endl;
			exit(EXIT_FAILURE);
			}  // case

		}// while

		if(tflag==0){
			cout << "Error. Falta el archivo de entrada de datos." << endl;
			exit(-1);
		}
		if(Tflag==0){
			Tvalue=tvalue;
		}



	PerceptronMulticapa mlp;

	Datos * pDatosTrain = mlp.leerDatos(tvalue);
	Datos * pDatosTest = mlp.leerDatos(Tvalue);

    // Inicializar el vector "topología"
    // (número de neuronas por cada capa, incluyendo la de entrada
    //  y la de salida)
    // ...


	// Sesgo
	mlp.bSesgo = bflag;

	// Online?
	mlp.bOnline = oflag;

	// Eta
	mlp.dEta = eta;

	// Mu
	mlp.dMu = mu;

    // Inicialización propiamente dicha
	// Inicializar el vector "topología"
		int *topologia = new int [numCapas+2];
		topologia[0]=pDatosTrain->nNumEntradas;
		for (int i=1; i<numCapas+1; i++){
			topologia[i]=hvalue;
		}
		topologia[numCapas+1]=pDatosTrain->nNumSalidas;

	mlp.inicializar(numCapas+2,topologia, sflag);

	int error=fvalue;

    // Semilla de los números aleatorios
    int semillas[] = {10,20,30,40,50};
    double *errores = new double[5];
    double *erroresTrain = new double[5];
    double *ccrs = new double[5];
    double *ccrsTrain = new double[5];
    for(int i=0; i<5; i++){
    	cout << "**********" << endl;
    	cout << "SEMILLA " << semillas[i] << endl;
    	cout << "**********" << endl;
		srand(semillas[i]);
		mlp.ejecutarAlgoritmo(pDatosTrain,pDatosTest,iteraciones,&(erroresTrain[i]),&(errores[i]),&(ccrsTrain[i]),&(ccrs[i]),error);
		cout << "Finalizamos => CCR de test final: " << ccrs[i] << endl;
    }

    // Calcular media y desviación típica de los errores de Train y de Test

    double mediaErrorTrain=0.0, desviacionTipicaErrorTrain=0.0, mediaError=0.0, desviacionTipicaError=0.0, mediaCCR=0.0, desviacionTipicaCCR=0.0, mediaCCRTrain=0.0, desviacionTipicaCCRTrain=0.0;
	for (int i=0; i<5; i++){
		mediaErrorTrain+=erroresTrain[i];
		mediaError+=errores[i];
		mediaCCRTrain+=ccrsTrain[i];
		mediaCCR+=ccrs[i];
	}
	mediaErrorTrain/=5;
	mediaError/=5;
	mediaCCRTrain/=5;
	mediaCCR/=5;

	for (int i=0; i<5; i++){
		desviacionTipicaErrorTrain+=pow(erroresTrain[i]-mediaErrorTrain, 2);
		desviacionTipicaError+=pow(errores[i]-mediaError, 2);
		desviacionTipicaCCR+=pow(ccrs[i]-mediaCCR, 2);
		desviacionTipicaCCRTrain+=pow(ccrsTrain[i]-mediaCCRTrain, 2);
	}

	desviacionTipicaErrorTrain/=4;
	desviacionTipicaError/=4;
	desviacionTipicaCCR/=4;
	desviacionTipicaCCRTrain/=4;

	desviacionTipicaErrorTrain=sqrt(desviacionTipicaErrorTrain);
	desviacionTipicaError=sqrt(desviacionTipicaError);
	desviacionTipicaCCR=sqrt(desviacionTipicaCCR);
	desviacionTipicaCCRTrain=sqrt(desviacionTipicaCCRTrain);

    cout << "TERMINADAS LAS CINCO SEMILLAS" << endl;

	cout << "RESUMEN FINAL" << endl;
	cout << "*************" << endl;
    cout << "Error de entrenamiento (Media DT): " << mediaErrorTrain << " " << desviacionTipicaErrorTrain << endl;
    cout << "Error de test (Media DT): " << mediaError << " " << desviacionTipicaError << endl;
    cout << "CCR de entrenamiento (Media DT): " << mediaCCRTrain << " " << desviacionTipicaCCRTrain << endl;
    cout << "CCR de test (Media DT): " << mediaCCR << " " << desviacionTipicaCCR << endl;

	return EXIT_SUCCESS;
}

