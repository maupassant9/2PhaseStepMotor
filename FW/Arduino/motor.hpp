/* 
* motor.h
* Author: Dong Xia 
* This is head file of 
* 
* Change Records: 
*      >> (02/09/2020): Creation of file 
* 
*/

#ifndef  _MOTOR_H_
#define _MOTOR_H_
/********************************************
* Include 
********************************************/


/********************************************
* Macro 
********************************************/
//Motor connection
//  PIN_A  ------------        -------------- PIN_C
//                     )      (
//        LOOPA       (        )  LOOPB
//                     )      (
//                    (        )
//  PIN_B  ------------        -------------- PIN_D
//#define PINA_PORT GPIOC
#define PINA_PIN 2

//#define PINB_PORT GPIOD
#define PINB_PIN 3

//#define PINC_PORT GPIOD
#define PINC_PIN 4

//#define PIND_PORT GPIOD
#define PIND_PIN 5


//#define MOTOR_FULLSTEP
#define MOTOR_HALFSTEP


#define ISR_DISABLE() 
#define ISR_ENABLE() 
/********************************************
* Type definition 
********************************************/
enum rotate_t{
	ROTATE_STOP = 0,
	ROTATE_CLK,
	ROTATE_CLKWISE
};

enum state_t{
  STOPPED = 0,
  ROTATING,
};

/********************************************
* Function prototype 
********************************************/
void MotorInit(void);
char MotorRotateDirection(enum rotate_t direction, uint16_t steps);
void MotorNextState( void );
enum state_t getMotorState();

#endif  //_MOTOR_H_

