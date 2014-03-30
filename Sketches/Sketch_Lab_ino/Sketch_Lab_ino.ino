#include "Servo.h" // attach the indicated library in order to use the included functions 
 
int servoPin1 = 3; // sets up variable for pin assignments 
int servoPin2 = 6;

int highPin = 5;
Servo servo1; // creates an instance of Servo in order to allow usage of functions. 
Servo servo2;
 
int sleft= 0; // full speed counter-clockwise 
int sright = 180; // full speed clockwise, note that this is relative and subject to change 
int sstop = 90; // Center value, so stops the servo at a value ~90, 
 
void setup() { 
 pinMode(servoPin1, OUTPUT); // initializes digital pin as an output pin
 pinMode(servoPin2, OUTPUT);
 servo1.attach(servoPin1); // appends the servo to the pin you assigned 
 servo2.attach(servoPin2);
 
 pinMode(highPin, OUTPUT);
 digitalWrite(highPin, HIGH);
} 
 
void loop() { 
 /*servo1.write(sleft); 
 servo2.write(sright);
 delay(1000); 
 servo1.write(sright); 
 servo2.write(sleft);
 delay(1000); */
 servo1.write(sstop);
 servo2.write(sstop);
 //delay(2000);
}
