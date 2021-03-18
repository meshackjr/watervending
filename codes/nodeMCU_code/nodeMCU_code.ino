#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>    //esp8266 library
#include <FirebaseArduino.h> 
#define FIREBASE_HOST "watervending-12e73-default-rtdb.firebaseio.com"  // the project name address from firebase id
#define FIREBASE_AUTH "dXhZdv9LUTAfPdINZ8yy7r8HxZPzzTKeHPBeIoeM"  // the secret key generated from firebase
                      

#define WIFI_SSID "Ventspur"                  // wifi name 
#define WIFI_PASSWORD "ReuSibia184"


#define delimiter '>'
#define eof '*'
SoftwareSerial mySerial(0,1); // RX, TX

String depth;
String coin;
String n;

int ind1;
int ind2;
int ind3;

String readString;

void setup(){
  Serial.begin(9600);
  mySerial.begin(9600);
  delay(1000);                
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);    
  mySerial.print("Connecting to ");
  mySerial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    mySerial.print(".");
    delay(500);
}
mySerial.println();
  mySerial.print("Connected to ");
  mySerial.println(WIFI_SSID);
  mySerial.print("IP Address is : ");
  mySerial.println(WiFi.localIP());                  //print local IP address
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);     // connect to firebase
}

void loop(){
    String inData = "";
    Serial.flush();
    inData = Serial.readString();
    Serial.flush(); 
    mySerial.println(inData);
    int i= inData.indexOf(eof);
    mySerial.println(i);
    ind1 = inData.indexOf(delimiter);
    depth = inData.substring(0,ind1);
    ind2 = inData.indexOf(eof,ind1+1);
    coin = inData.substring(ind1+1,ind2);
    
    mySerial.println("data1: "+ depth);
    mySerial.println("data2: "+ coin);

    if(coin.toInt() > 0){
      //Distance = Depth
      Firebase.setInt("ULTRA/Distance", depth.toInt());
      Firebase.pushInt("ULTRA/Distances", depth.toInt());
  
      // (int) coin
  
      //Temperature = Coin
      Firebase.setInt("DHT11/Temperature",coin.toInt());
      Firebase.pushInt("DHT11/Temperatures",coin.toInt());
  
      StaticJsonBuffer<200> jsonBuffer;
      JsonObject& root = jsonBuffer.createObject();
      root["coin"] = coin.toInt();
    
      Firebase.push("/sensor", root);  
    }
    
    coin = "";
    depth = "" ;
  delay (2000);
}
