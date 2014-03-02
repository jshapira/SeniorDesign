/*
  Web Server
 
 A simple web server that shows the value of the analog input pins.
 using an Arduino Wiznet Ethernet shield. 
 
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 * Analog inputs attached to pins A0 through A5 (optional)
 
 created 18 Dec 2009
 by David A. Mellis
 modified 9 Apr 2012
 by Tom Igoe
 
 */

#include <SPI.h>
#include <Ethernet.h>
#include "Servo.h"

int servoPin1 = 3;
int highPin = 5;
Servo servo1;

int sleft = 0; 
int sright = 180;
int sstop = 90;

boolean incoming = 0;
// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = { 
   0x90, 0xA2, 0xDA, 0x0D, 0xEA, 0x42 };
IPAddress ip(192,168,1,2);

// Initialize the Ethernet server library
// with the IP address and port you want to use 
// (port 80 is default for HTTP):
EthernetServer server(80);

void setup() {
 // Open serial communications and wait for port to open:
  
  ////
  pinMode(servoPin1, OUTPUT); 
  servo1.attach(servoPin1);
  pinMode(highPin, OUTPUT);
  digitalWrite(highPin, HIGH);
  ////
  
  Serial.begin(9600);
   while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }


  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
}


void loop() {
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
    Serial.println("new client");
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
       // Serial.write(c);
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if(incoming && c == ' ')
        //reads URL string from $ to first blank space
        { 
          incoming = 0;
        }
        if(c == '$'){ 
        // if we received a $ sign then we have received a request
          incoming = 1; 
        }
         //Check for the URL string $1 or $2
        if(incoming == 1){
          Serial.println(c);
          // printing the result on the serial port (on your computer)
          if(c == '1'){
            Serial.println("ON");
            // printing "ON" to your screen.
            servo1.write(sleft);
            // setting the 2nd pin state to HIGH (turning on the LED)
          }
          if(c == '2'){
            Serial.println("OFF");
            // printing "OFF" to your screen.
            servo1.write(sright);
            // setting the our LED state to off (turning it off)
          }
 
        }
        
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
    }
    // give the web browser time to receive the data
    delay(1);
    // close the connection:
    client.stop();
    Serial.println("client disonnected");
  }
}

