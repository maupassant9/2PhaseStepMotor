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
#include <Arduino.h>
#include "motor.hpp"



/********************************************
* Internal Types and Variables 
********************************************/
#if !defined(MOTOR_HALFSTEP) && !defined(MOTOR_FULLSTEP)
#define MOTOR_FULLSTEP
#endif

#ifdef MOTOR_HALFSTEP
#define MOTOR_PHASE_SZ (8)
uint8_t motorPinMatrix[MOTOR_PHASE_SZ] = {1,3,2,6,4,0xc,8,9};
#else 
#ifdef MOTOR_FULLSTEP
#define MOTOR_PHASE_SZ (4)
uint8_t motorPinMatrix[MOTOR_PHASE_SZ] = {3,6,0xc,9};
#endif
#endif
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
	MOTOR_PHASE_4,
  MOTOR_PHASE_5,
  MOTOR_PHASE_6,
  MOTOR_PHASE_7,
  MOTOR_PHASE_8
};
/********************************************
* External Variables 
********************************************/
//GPIO PIN ON/OFF order
//PINA and PINB can not be ON at the same time
//PINC and PIND can not be ON at the same time
static enum motor_state_t orders[MOTOR_PHASE_SZ];
static unsigned char order_cnter;
static uint16_t steps = 0;
enum state_t state;
static volatile uint8_t lock = 0;

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
	unsigned char cnt;
	
	MotorGpioInit();
	//init the state of motor
	MotorRotateDirection(ROTATE_STOP, 0);
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
char MotorRotateDirection(enum rotate_t direction, uint16_t s){
  if(state == ROTATING) return -1;

  #ifdef MOTOR_HALFSTEP
  steps = s * 2;
  #else
  steps = s;
  #endif
  
	if(ROTATE_CLK == direction){
		for(int i = 0; i < MOTOR_PHASE_SZ; i++)
      orders[i] = i+1;
    state = ROTATING;
	} else if (ROTATE_CLKWISE == direction){
    for(int i = 0; i < MOTOR_PHASE_SZ; i++)
      orders[i] = MOTOR_PHASE_SZ - i;
    state = ROTATING;
	} else {
    for(int i = 0; i <= MOTOR_PHASE_SZ; i++)
      orders[i] = MOTOR_LOOP_OFF;
    state = STOPPED;
	}
  return 0;
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
	enum motor_state_t st;
	order_cnter++;
	if(order_cnter == MOTOR_PHASE_SZ) {
		order_cnter = 0;
	}

	st = orders[order_cnter];

	MotorApplyState(st);	
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
static void MotorApplyState(enum motor_state_t st)
{
  uint8_t ctrbit = 0;
  if(st != MOTOR_LOOP_OFF) {
    if(steps > 0) steps--;
    if(steps != 0) {
      ctrbit = motorPinMatrix[st-1];
    }
  }
  digitalWrite(PINA_PIN, (ctrbit&0b1)?HIGH:LOW);
  digitalWrite(PINB_PIN, (ctrbit&0b10)?HIGH:LOW);
  digitalWrite(PINC_PIN, (ctrbit&0b100)?HIGH:LOW);
  digitalWrite(PIND_PIN, (ctrbit&0b1000)?HIGH:LOW);
  if(ctrbit) state = ROTATING;
  else state = STOPPED;
}


enum state_t getMotorState()
{
  return state;
}

// bool getLock()
// {
//   if (lock) return 0;
//   ISR_DISABLE();
//   if(lock == 0){ 
//     lock = 1;
//     ISR_ENABLE();
//     return 1;
//   } else {
//     ISR_ENABLE();
//     return 0;
//   }
// }

// bool releaseLock()
// {
//   ISR_DISABLE();
//   lock = 0;
//   ISR_ENABLE();
// }
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
	pinMode(PINA_PIN, OUTPUT);
  pinMode(PINB_PIN, OUTPUT);
  pinMode(PINC_PIN, OUTPUT);
  pinMode(PIND_PIN, OUTPUT);
}