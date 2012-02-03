#include <math.h>
#define ANALOG_IN 0
void setup() {
  Serial.begin(9600); 
}
void loop() {
  
 /////------------------------------------------------------------------------------Obtención de datos
  int h=64;    // Taza de refresco de 0.5 Hz aprox        
  double f[h];
  double F[h];
  double Real[h];
  double Imag[h];
  double Final[8];
  
 /////------------------------------------------------------------------------------Iniciando variables
    
    for (int i=0; i < h; i=i+1){ 
      Real[i]=0; 
   }  
    for (int i=0; i < h; i=i+1){  
      Imag[i]=0;  
   }  
  for (int i=0; i < h; i=i+1){   
      f[i]=analogRead(ANALOG_IN)*5/1024;  //Obtiene un vector en el tiempo normalizado al voltaje        
   }  
   for (int i=0; i < 7; i=i+1){  
      Final[i]=0;  
   }
   
 /////---------------------------------------------------------------------------------Sacando Fourier
   
   for(int j=0; j<h;j=j++){                        
    for(int u=0; u<h;u=u+1){
      Real[j]=Real[j]+ f[u]*sin((2*3.14*u*j/h));   // Vector parte Real
     }
  }   
   for(int j=0; j<h;j=j++){                      
    for(int u=0; u<h;u=u+1){
      Imag[j]=Imag[j]+ f[u]*cos(-2*3.14*u*j/h);    // Vector parte Imag
      }   
   }     
      for(int j=0; j<h;j=j+1){                
     F[j]=sqrt(pow(Real[j],2)+pow(Imag[j],2));     // Valor absoluto entre Real e Imaginario  
         Serial.print(F[j]);
  Serial.print(" ");
  } 
  
  delay(10000);
  
  
/////-----------------------------------------------------------------------------Adecuando al hardware  

   for(int j=2; j<7;j=j+1){           // No considero el primer punto por distorisión     
     Final[0]=Final[0]+F[j]/8;      
  } 
   for(int j=8; j<15;j=j+1){                
     Final[1]=Final[1]+F[j]/8;      
  } 
   for(int j=16; j<23;j=j+1){                
     Final[2]=Final[2]+F[j]/8;      
  } 
   for(int j=24; j<31;j=j+1){                
     Final[3]=Final[3]+F[j]/8;      
  } 
   for(int j=32; j<39;j=j+1){                
     Final[4]=Final[4]+F[j]/8;      
  } 
   for(int j=40; j<47;j=j+1){                
     Final[5]=Final[5]+F[j]/8;      
  } 
   for(int j=48; j<55;j=j+1){                
     Final[6]=Final[6]+F[j]/8;      
  } 
   for(int j=56; j<59;j=j+1){     /// El punto 62 y 63 (los últimos punto de la transformada) no los considero                
     Final[7]=Final[7]+F[j]/8;    /// debido a su distrosión   
  } 














}
