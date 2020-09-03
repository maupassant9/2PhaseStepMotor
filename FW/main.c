/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s.h"
#include "motor.h"


void main( void )
{
	MotorInit();
	
	MotorRotateDirection(ROTATE_CLK);
	
	while(1){
		MotorNextState();
		dly();
	}
}


void dly()
{
	uint32_t cnt;
	for(cnt = 0; cnt < 0xfff; cnt++);
}

