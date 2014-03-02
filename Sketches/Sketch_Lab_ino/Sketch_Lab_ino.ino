#include "Servo.h" // attach the indicated library in order to use the included functions 
 
int servoPin1 = 3; // sets up variable for pin assignments 

int highPin = 5;
Servo servo1; // creates an instance of Servo in order to allow usage of functions. 
 
int sleft= 0; // full speed counter-clockwise 
int sright = 180; // full speed clockwise, note that this is relative and subject to change 
int sstop = 90; // Center value, so stops the servo at a value ~90, 
 
void setup() { 
 pinMode(servoPin1, OUTPUT); // initializes digital pin as an output pin 

 servo1.attach(servoPin1); // appends the servo to the pin you assigned 
 
 pinMode(highPin, OUTPUT);
 digitalWrite(highPin, HIGH);
} 
 
void loop() { 
 servo1.write(sleft); 
 delay(1000); 
 servo1.write(sright); 
 delay(1000); 
 servo1.write(sstop);
 delay(2000);
}