#include <SPI.h> //Library for using SPI Communication
#include <mcp2515.h> //Library for using CAN Communication

struct can_frame canMsg;
MCP2515 mcp2515(10);

void setup(){
  while (!Serial);
  Serial.begin(9600);
  SPI.begin(); //Begins SPI communication
  mcp2515.reset();
  mcp2515.setBitrate(CAN_1000KBPS, MCP_8MHZ); //Sets CAN at speed 500KBPS and Clock 8MHz
  mcp2515.setNormalMode();
  pinMode(5,INPUT);
  pinMode(6,INPUT);
}

void loop(){

  if(digitalRead(5)==1) //5 maksud butang, push pedal situation
  {
  canMsg.can_id = 0x034; //CAN id as pedal push
  canMsg.can_dlc = 1; //CAN data length as 1 byte
  canMsg.data[0] = 1; //push pedal
  mcp2515.sendMessage(&canMsg); //Sends the CAN message
  
  Serial.println("push");
  
  }
  else
  {
  canMsg.can_id = 0x034; //CAN id as pedal push
  canMsg.can_dlc = 1; //CAN data length as 1 byte
  canMsg.data[0] = 0; //push pedal
  mcp2515.sendMessage(&canMsg); //Sends the CAN message
  delay(1);
  
  }

if(digitalRead(6)==1) //6 maksud butang, release pedal situation
  {
  canMsg.can_id = 0x036; //CAN id as pedal release
  canMsg.can_dlc = 1; //CAN data length as 1 byte
  canMsg.data[0] = 1; //release pedal
  mcp2515.sendMessage(&canMsg); //Sends the CAN message
  Serial.println("release");
  
  }
  else
  {
  canMsg.can_id = 0x036; //CAN id as pedal push
  canMsg.can_dlc = 1; //CAN data length as 1 byte
  canMsg.data[0] = 0; //push pedal
  mcp2515.sendMessage(&canMsg); //Sends the CAN message
   delay(1);
  }

 
}
