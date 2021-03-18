//YWROBOT
//Compatible with the Arduino IDE 1.0
//Library version:1.1
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h>
#include "Nokia_5110.h"

// Status Led
byte statusLed    = 13;

// Ultrasonic
const byte trig = 8;
const byte echo = 9;

unsigned long ultrasonicOldTime;
unsigned int waterDepth;

// Coin Acceptor
const byte coinAcceptorInterrupt = 4;
const byte coinAcceptorPin = 19;

const byte coinAcceptorRelayPin = 49;

volatile byte coinAcceptorPulseCount;

// Water Flow Sensor
const byte waterFlowInterrupt = 5;  // 1 = digital pin 3
const byte waterFlowPin       = 18;

// The hall-effect flow sensor outputs approximately 4.5 pulses per second per
// litre/minute of flow.
float calibrationFactor = 4.5;

volatile byte waterFlowPulseCount;  

float flowRate;
unsigned int flowMilliLitres;
unsigned long totalMilliLitres;

unsigned long oldTime;

// Motor Driver
const byte in1 = 31;
const byte in2 = 33;
const byte in3 = 35;
const byte in4 = 37;

// Serial to NodeMCU
SoftwareSerial serialToNode(16,17);

#define delimiter '>'
#define eof '*'

unsigned long nodeOldTime = 0;


int depth = 10;   // Water Container Depth

const byte nodeTX = 16;
const byte nodeRX = 17;

// Display
byte RST = 45;
byte CE = 43;
byte DC = 41;
byte DIN = 21;
byte CLK = 20;
Nokia_5110 lcd = Nokia_5110(RST, CE, DC, DIN, CLK);
//LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

// Flags for conditions checking
bool conditions = false;
unsigned long conditionsOldTime = 0;
bool filling;

// Reporting Variable
unsigned long totalFilledWater = 0;
unsigned long totalCoins = 0;
unsigned int coinsToSend = 0;

// Volume of water to fill
int volumeOfWater = 100;

void setup()
{
  // Serial Initialization
  serialToNode.begin(9600);
  Serial.begin(9600);
  
  // Set up ultrasonic
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);

  ultrasonicOldTime = 0;
  waterDepth = 0;

  // Set up motor Driver
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);

  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);

  // Initialize LCD Display
//  lcd.init();                      // initialize the lcd 
//  lcd.init();

//  lcd.backlight();
  message(0, "MAJI SAFI");
  message(2, "Tsh 200/=");


  // Initialize Serial
  Serial.println("Welcome");

  // Set up the status LED line as an output
  pinMode(statusLed, OUTPUT);
  digitalWrite(statusLed, HIGH);  // We have an active-low LED attached

  // Initialize Coin Acceptor Variables and pins
  coinAcceptorPulseCount = 0;

  pinMode(coinAcceptorPin, INPUT_PULLUP);
  digitalWrite(coinAcceptorPin, HIGH);
  attachInterrupt(digitalPinToInterrupt(19), coinAcceptorPulseCounter, HIGH);


  pinMode(coinAcceptorRelayPin, OUTPUT);
  digitalWrite(coinAcceptorRelayPin, LOW);
  

  // Initialize Water Flow Sensor Variables and Pins
  pinMode(waterFlowPin, INPUT);
  digitalWrite(waterFlowPin, HIGH);

  waterFlowPulseCount        = 0;
  flowRate          = 0.0;
  flowMilliLitres   = 0;
  totalMilliLitres  = 0;
  oldTime           = 0;

  attachInterrupt(waterFlowInterrupt, waterFlowPulseCounter, FALLING);
}


void loop()
{
  // Measure depth on repeat every 2 seconds;
  measureDepth();
  
// Check conditions
  checkConditions();

  checkCoinAndFill();
  sendData();
}


void sendData()
{
  if((millis() - nodeOldTime) > 5000){
    String sendData = String(waterDepth) + String(delimiter) + String(500 * coinsToSend) + String(eof) ;
      Serial.println("pulse: ");
      Serial.println(coinsToSend);
      serialToNode.println(sendData);
      Serial.println(sendData);
      Serial.flush();
      sendData = " ";
      coinsToSend = 0;
      nodeOldTime = millis();
  }
}

void countFilledVolume(){
  if((millis() - oldTime) > 1000)    // Only process counters once per second
  { 
    // Disable the interrupt while calculating flow rate and sending the value to
    // the host
    // detachInterrupt(sensorInterrupt);
        
    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate = ((1000.0 / (millis() - oldTime)) * waterFlowPulseCount) / calibrationFactor;
    
    // Note the time this processing pass was executed. Note that because we've
    // disabled interrupts the millis() function won't actually be incrementing right
    // at this point, but it will still return the value it was set to just before
    // interrupts went away.
    oldTime = millis();
    
    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres = (flowRate / 60) * 1000;
    
    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres += flowMilliLitres;

    //Serial.println(totalMilliLitres);
          
    // Reset the pulse counter so we can start incrementing again
    waterFlowPulseCount = 0;
    
    // Enable the interrupt again now that we've finished sending output
    // attachInterrupt(sensorInterrupt, pulseCounter, FALLING);
  }
}

void waterValveOn(){
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
}

void waterValveOff(){
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
}

void waterPumpOn(){
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
}

void waterPumpOff(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
}

void coinAcceptorOn(){
  digitalWrite(coinAcceptorRelayPin, LOW);
}

void coinAcceptorOff(){
    digitalWrite(coinAcceptorRelayPin, HIGH);
}

// Read digital signal for coin
void checkCoinAndFill(){
  if((totalMilliLitres < volumeOfWater)&&(coinAcceptorPulseCount > 7) && conditions){
    
     // Coin is found
     message(4, "Sarafu Imepatikana");
  
     // Swith off coin acceptor
     coinAcceptorOff();
     
     // Switch on valve
     waterValveOn();

     // Switch on pump
     waterPumpOn();
     
     // Read flowing water
     countFilledVolume();

     // Started filling
     filling = true;
   }
   else if(coinAcceptorPulseCount && totalMilliLitres > volumeOfWater){

    // Switch off pump
     waterPumpOff();
     
     // Stop valve
     waterValveOff();
     
    // Record total water
    totalFilledWater += totalMilliLitres;
    
    // Record Coin
    totalCoins++;
    
    // Reset water flow
    waterFlowPulseCount = 0;
    flowRate          = 0.0;
    flowMilliLitres   = 0;
    totalMilliLitres  = 0;
    oldTime           = 0;
      
    // Reset coinPulses
    coinAcceptorPulseCount = 0;
    coinsToSend++;
    
    // Start the coin acceptor
    coinAcceptorOn();
    
    // Send Data
    sendData();

    // finished filling
    filling = false;

    message(3, " ");
   }
}

int measureDepth(){
  if((millis() - ultrasonicOldTime) > 1000){
    ultrasonicOldTime = millis();
    digitalWrite(trig, LOW);
    delayMicroseconds(2);
    
    digitalWrite(trig, HIGH);
    delayMicroseconds(10);
  
    digitalWrite(trig, LOW);
  
    int duration = pulseIn(echo, HIGH);
    waterDepth = duration * 0.034/2;
  
//    message(4, "Depth is ");
//    lcd.print(waterDepth);
//    lcd.print(" cm   ");
  
    return depth;
  }
}

void checkConditions(){
  if((millis() - conditionsOldTime) > 1000)    // Only process counters once per second
  {
    conditionsOldTime = millis();
    // While filling do nothing
    if(filling){
       message(4, "Maji Yanatoka...");  
     }
     
    // Check depth & report
    else if(waterDepth > 45){
       message(4, "Maji Hayatoshi!");
        coinAcceptorOff();
       conditions = false;
    }else{
      conditions = true;
      coinAcceptorOn();
      message(4, " Ingiza Sarafu."); 
    }
  }
}


/*
Insterrupt Service Routine
 */
void waterFlowPulseCounter()
{
  // Increment the pulse counter
  waterFlowPulseCount++;
}

void coinAcceptorPulseCounter(){
  //  Increment the pulses
  coinAcceptorPulseCount++;
  Serial.println("Coin accepted");
}

void message(int line, String message){
  lcd.setCursor(0, line);
  lcd.print("                 ");
  lcd.setCursor(0, line);
  lcd.print(message);
}
