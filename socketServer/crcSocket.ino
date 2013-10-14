#include <SPI.h>
#include <Ethernet.h>
#include <Servo.h>
// Enter a MAC address, IP address and Portnumber for your Server below.
// The IP address will be dependent on your local network:
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,25, 6);        
byte gateway[] = { 192, 168, 25, 1 };
int serverPort=80;
// Initialize the Ethernet server library
// with the IP address and port you want to use
EthernetServer server(serverPort);

Servo myservo;

void setup()
{
  // start the serial for debugging
  Serial.begin(9600);
  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip,gateway);
  server.begin();
  Serial.println("Server started");//log
  pinMode(8, OUTPUT);
  myservo.attach(A0);
}
 
void loop()
{
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
    String clientMsg =String(30);
    Serial.println("Connected");
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        //Serial.print(c);
        clientMsg+=c;//store the recieved chracters in a string
        //if the character is an "end of line" the whole message is recieved
        if (c == '\n') {
          //Serial.println("Message from Client:"+clientMsg);//print it to the serial
          
          if(clientMsg.indexOf("ledon")>0)
          {
              Serial.println("Led is On");
              digitalWrite(8, HIGH);
          }
          else
          {
            if(clientMsg.indexOf("ledoff")>0)
            {
                Serial.println("Led is Off");
                digitalWrite(8, LOW);
            }
            else
            {
              if(clientMsg.indexOf("opendoor")>0)
              {
                Serial.println("door opened");
                myservo.write(0);
              }
              else
              {
                if(clientMsg.indexOf("closedoor")>0)
                {
                  Serial.println("door closed");
                  myservo.write(90);
                }
              }
            }
          }
          client.println(clientMsg);//modify the string and send it back
          clientMsg="";
        }
      }
    }
    // give the Client time to receive the data
    delay(200);
    // close the connection:
    client.stop();
  }
}
