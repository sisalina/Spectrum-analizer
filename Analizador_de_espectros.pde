#include <math.h>
#define ANALOG_IN 5
#include <glcd.h>
#include "fonts/allFonts.h"
#include "bitmaps/allBitmaps.h"
Image_t icon;

void setup() {
Serial.begin(9600); 
GLCD.Init();
GLCD.ClearScreen();
GLCD.SelectFont(System5x7,BLACK);
icon = catolica;
}

void loop() {
  GLCD.DrawBitmap(catolica, 40,5);
  delay(2000);
  fourier();
}

void ejes(){
GLCD.DrawLine(4,60,124,60);
   for(int j=5; j<124;j=j+4){                
     GLCD.DrawLine(j,60,j,61);      
  } 
}

void  fourier(){
  int var = 0;
while(var < 1){
  /////------------------------------------------------------------------------------Obtención de datos
  int h=64;    // Taza de refresco de 0.5 Hz aprox        
  double f[h];
  double F[h];
  double Y[h];
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
      Imag[j]=Imag[j]+ f[u]*cos(-2*3.14*u*j/h);    // Vector parte Imag  
   }
   F[j]=sqrt(pow(Real[j],2)+pow(Imag[j],2));
  }   

/////---------------------------------------------------------------------------Llevando a fftshift

   for (int i=0; i < 31; i=i+1){  
      Y[i]=F[32+i];  
   }

  for (int i=0; i < 30; i=i+1){  // Me como el F[0]...Muy distorsionado
      Y[i+31]=F[i+1];  
   }
   
/////-------------------------------------------------------------------------Time to draw
  
  GLCD.ClearScreen();
  ejes();
for(int j=0; j<63;j=j+1){                
     GLCD.DrawLine(2*j+4,60,2*j+2,abs(60-Y[j+1]));      
  } 
 }
}
