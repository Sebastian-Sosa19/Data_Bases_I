/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
C#, VB, Perl, Swift, Prolog, Javascript, Pascal, HTML, CSS, JS
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/

#include <iostream>
#include <string>
using namespace std;

char fecha[9];

//Se crea un arreglo de 12 items con los nombres de cada mes.

string meses[12] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo",

                    "Junio","Julio","Agosto","Septiempre","Octubre",

                    "Noviembre","Diciembre"};

void mostrarFecha(int dia, int mes, int anio);

int main(){   
    
	fecha;

    cout<<"Ingrese fecha DD-MM-AAAA"<<endl;

    cin>>fecha;
    
	//Con el formato de fecha indicado, se capturan los valores correspondientes en la fecha.

    string aaaa = {fecha[6],fecha[7],fecha[8],fecha[9]};

    string mm = {fecha[3],fecha[4]};

    string dd = {fecha[0],fecha[1]};
    
    //Luego de capturar los valores, se convierten a enteros y se les asigna a otra variable.

    int anio = std::stoi(aaaa);    
	int mes = std::stoi(mm);
	int dia = std::stoi(dd);
    
    //Se manda a llamar a la función para mostrar la fecha, tomando como parámetros los valores extraidos de la cadena ingresada.
	mostrarFecha(dia, mes, anio);

    return 0;

}

void mostrarFecha(int dia, int mes, int anio){    
    //Se asigna una variable de cadena de texto para identificar el mes.

    string month;
    int contador = 0;    

	//Variable que verá si el año es bisiesto.	
    bool bisiesto = false;
    
    //Dado que en 10000 años hay 2500 bisiestos, se plantea el siguiente ciclo.
    for(int i = 0; i<=2500;  i++){
        
        //Si el contador coincide con el año ingresado, entonces este es bisiesto.
        if(anio == contador){

	        bisiesto = true;
            
		    break;

        }else{

        	//De lo contrario, sumará cuatro años mas al contador hasta encontrarlo.
            contador+=4;

        	}

    	}

	//Se verifica que el año ingresado este en los límites indicados.
    	if(anio>0 && anio<=10000){
        
        //Se verifica que el número de mes sea entre 1 y 12.
            if(mes>0 && mes<13){
            
            //Primero vemos si el día está en el rango de 31 máximo.
            	if(dia>0 && dia<32){
                
					//De ser así, se verá si su mes coincide con los de 31 días.                
				    if(mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10 || mes == 12){
			
                        month = meses[mes - 1];            
            
					//De no entrar en el ciclo anterior, pasamos a los meses con 30 días.                
					} else if(dia>0 && dia<31){	
                    
                //Y vemos si cumple con el requisito.				
                if(mes == 4 || mes == 6 || mes == 9 || mes == 11){

				    month = meses[mes - 1];
	                  
                //Por ultimo deben ser días entre 1 y 29.                    
				} else if(dia>0 && dia<30){
	                        
                    //Si el día es distinto de 29, se le asigna el mes de febrero.			
                    if(dia<29){
				
                        month = meses[1]; 
                            
                    //Si el día es 29 se debe cumplir que sea un año bisiesto, entonces asignamos el mes de febrero.				
                    }else if(dia == 29 && bisiesto){
				
                        month = meses[1];	
                        
                    //Si nada se cumple, la fecha está incorrecta.
				    }else{
				
                        cout<<"Fecha no valida";				
                        exit (-1);
				            }		
        
                        }		
        
                    }	            
            
            }else{

				cout<<"Fecha no valida";
				
                exit (-1);
		
            }

		}

        
  	}

    
    //Ahora, si el año es bisiesto, se indica en pantalla junto a la fecha.

    if(bisiesto){

        if(month == ""){

	        cout<<"Fecha no valida";

        }else{
            cout<<"¡Es año bisiesto!"<<endl;
            cout<<dia<<" de "<<month<<" de "<<anio;
        }
    }else{
        if(month == ""){
      		cout<<"Fecha no valida";

        }else{
            
		cout<<dia<<" de "<<month<<" de "<<anio;
	    }

    }

}
