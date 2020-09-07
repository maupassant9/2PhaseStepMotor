/*
* motor.c 
* Author: Dong Xia
* Controller of 2 phase step motor
* The H-bridge is used, the fw should be very 
* careful with the H-bridge.
*
* Change Records:
*      >> (02/09/2020): 
*
*/

/********************************************
* Include 
********************************************/
#include "motor.h"
#include "stm8s.h"



/********************************************
* Internal Types and Variables 
********************************************/


// MOTOR_PHASE_1 -- 4
//            A  B  C  D
//  PHASE_1:  1  0  0  1
//  PHASE_2:  1  0  1  0
//  PHASE_3:  0  1  1  0
//  PHASE_4:  0  1  0  1
enum motor_state_t{
	MOTOR_LOOP_OFF = 0,
	MOTOR_PHASE_1,
	MOTOR_PHASE_2,
	MOTOR_PHASE_3,
	MOTOR_PHASE_4
};
/********************************************
* External Variables 
********************************************/
//GPIO PIN ON/OFF order
//PINA and PINB can not be ON at the same time
//PINC and PIND can not be ON at the same time
static enum motor_state_t orders[4];
static uint8_t order_cnter;


/********************************************
* Internal Function Declaration 
********************************************/
static void MotorApplyState(enum motor_state_t state);
static void MotorGpioInit( void );

/********************************************
* Functions 
********************************************/
/*------------------------------------------------ 
* MotorInit 
* Init the step motor variables
* Paras:
*  >> : 
*  >> : 
* Return: 
*  >> 
* Change Records: 
*  >> (02/09/2020): Create the function 
*----------------------------------------------*/
void MotorInit(void)
{
	uint8_t cnt;
	
	MotorGpioInit();
	//init the state of motor
	MotorRotateDirection(ROTATE_STOP);
	order_cnter = 0;
}

/*------------------------------------------------ 
* MotorRotateDirection 
* Change the rotate direction 
* Paras:
*  >> : 
*  >> : 
* Return: 
*  >> 
* Change Records: 
*  >> (02/09/2020): Create the function 
*----------------------------------------------*/
void MotorRotateDirection(enum rotate_t direction){
	if(ROTATE_CLK == direction){
		orders[0] = MOTOR_PHASE_1;
		orders[1] = MOTOR_PHASE_2;
		orders[2] = MOTOR_PHASE_3;
		orders[3] = MOTOR_PHASE_4;
	} else if (ROTATE_CLKWISE == direction){
		orders[0] = MOTOR_PHASE_4;
		orders[1] = MOTOR_PHASE_3;
		orders[2] = MOTOR_PHASE_2;
		orders[3] = MOTOR_PHASE_1;
	} else {
		orders[0] = MOTOR_LOOP_OFF;
		orders[1] = MOTOR_LOOP_OFF;
		orders[2] = MOTOR_LOOP_OFF;
		orders[3] = MOTOR_LOOP_OFF;
	}
}


/*------------------------------------------------ 
* MotorNextState 
* Move to the next state of the motor 
* This function can be called inside isr or inside loop
* Paras:
*  >> : 
*  >> : 
* Return: 
*  >> 
* Change Records: 
*  >> (02/09/2020): Create the function 
*----------------------------------------------*/
void MotorNextState( void ){
	
	order_cnter++;
	if(order_cnter == 4) {
		order_cnter = 0;
	}
	
	MotorApplyState(orders[order_cnter]);	
}

/*------------------------------------------------ 
* MotorApplyState 
* Apply the state into motor 
* Paras:
*  >> : 
*  >> : 
* Return: 
*  >> 
* Change Records: 
*  >> (02/09/2020): Create the function 
*----------------------------------------------*/
static void MotorApplyState(enum motor_state_t state)
{
	//switch to next state
	switch(state){
		case MOTOR_PHASE_1: 
												 PINC_PORT->ODR &= ~PINC_PIN;
												 PINB_PORT->ODR &= ~PINB_PIN;
												 PINA_PORT->ODR |= PINA_PIN;
												 PIND_PORT->ODR |= PIND_PIN;
												 break;
		case MOTOR_PHASE_2: 
												 PINB_PORT->ODR &= ~PINB_PIN;	
												 PIND_PORT->ODR &= ~PIND_PIN;
												 PINA_PORT->ODR |= PINA_PIN;
												 PINC_PORT->ODR |= PINC_PIN;
												 
												 break;
		case MOTOR_PHASE_3:
												 PINA_PORT->ODR &= ~PINA_PIN;
												 PIND_PORT->ODR &= ~PIND_PIN;
												 PINB_PORT->ODR |= PINB_PIN;		
												 PINC_PORT->ODR |= PINC_PIN;	
												 break;												 
		case MOTOR_PHASE_4:
												 PINA_PORT->ODR &= ~PINA_PIN;	
												 PINC_PORT->ODR &= ~PINC_PIN;
												 PIND_PORT->ODR |= PIND_PIN;	
												 PINB_PORT->ODR |= PINB_PIN;	
												 break;
		default:
						 PINA_PORT->ODR &= ~PINA_PIN;
						 PINB_PORT->ODR &= ~PINB_PIN;	
						 PINC_PORT->ODR &= ~PINC_PIN;
						 PIND_PORT->ODR &= ~PIND_PIN;
						 break;
	}
	
}

/*------------------------------------------------ 
* MotorGpioInit 
* Init the gpio used by motor 
* Paras:
*  >> : 
*  >> : 
* Return: 
*  >> 
* Change Records: 
*  >> (02/09/2020): Create the function 
*----------------------------------------------*/
static void MotorGpioInit( void )
{
	//init the gpio
	PINA_PORT->ODR &= ~PINA_PIN;
	PINB_PORT->ODR &= ~PINB_PIN;
	PINC_PORT->ODR &= ~PINC_PIN;
	PIND_PORT->ODR &= ~PIND_PIN;
	
	PINA_PORT->DDR |= PINA_PIN;
	PINB_PORT->DDR |= PINB_PIN;
	PINC_PORT->DDR |= PINC_PIN;
	PIND_PORT->DDR |= PIND_PIN;
	
	PINA_PORT->CR1 |= PINA_PIN;
	PINB_PORT->CR1 |= PINB_PIN;
	PINC_PORT->CR1 |= PINC_PIN;
	PIND_PORT->CR1 |= PIND_PIN;
	
	//set to 2MHz low speed 
	PINA_PORT->CR2 &= ~PINA_PIN;
	PINB_PORT->CR2 &= ~PINB_PIN;
	PINC_PORT->CR2 &= ~PINC_PIN;
	PIND_PORT->CR2 &= ~PIND_PIN;
}