#include "motor.hpp"
enum rotate_t nxtRotate = ROTATE_CLKWISE;

void setup() {
  // put your setup code here, to run once:
  MotorInit();
	while (MotorRotateDirection(nxtRotate, 2048) < 0){
    delay(1000);
  };
  nxtRotate = ((nxtRotate == ROTATE_CLK)?ROTATE_CLKWISE:ROTATE_CLK);
}

void loop() {
  // put your main code here, to run repeatedly:
  MotorNextState();
  delay(4);
  if(MotorRotateDirection(nxtRotate, 2048) >= 0){
    nxtRotate = ((nxtRotate == ROTATE_CLK)?ROTATE_CLKWISE:ROTATE_CLK);
  }
}
