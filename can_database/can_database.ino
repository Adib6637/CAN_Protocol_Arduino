#include <SPI.h> //Library for using SPI Communication 
#include <mcp2515.h> //Library for using CAN Communication

struct can_frame canMsg; 
MCP2515 mcp2515(10); // SPI CS Pin 10 

void setup() {
  SPI.begin();   //Begins SPI communication
  Serial.begin(9600); //Begins Serial Communication at 9600 baud rate 
  mcp2515.reset();                          
  mcp2515.setBitrate(CAN_1000KBPS,MCP_8MHZ); //Sets CAN at speed 500KBPS and Clock 8MHz 
  mcp2515.setNormalMode();  //Sets CAN at normal mode
  pinMode(7, OUTPUT);
  pinMode(5, OUTPUT);
}

void loop(){
 if ((mcp2515.readMessage(&canMsg) == MCP2515::ERROR_OK) && (canMsg.can_id == 0x034)){
     int pedal_push = canMsg.data[0];
     Serial.print(" pedal_push: ");
     Serial.println(pedal_push);
     digitalWrite(5,pedal_push);
   }

  if ((mcp2515.readMessage(&canMsg) == MCP2515::ERROR_OK) && (canMsg.can_id == 0x036)){            
    int pedal_release = canMsg.data[0]; 
      Serial.print(" pedal_release: ");
     Serial.println(pedal_release);
     digitalWrite(7,pedal_release);
   }
}

