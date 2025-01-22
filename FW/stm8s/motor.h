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
#define PINA_PORT GPIOC
#define PINA_PIN 0x80

#define PINB_PORT GPIOD
#define PINB_PIN 0x02

#define PINC_PORT GPIOD
#define PINC_PIN 0x04

#define PIND_PORT GPIOD
#define PIND_PIN 0x08

/********************************************
* Type definition 
********************************************/
typedef enum rotate_t{
	ROTATE_STOP = 0,
	ROTATE_CLK,
	ROTATE_CLKWISE
};
/********************************************
* Function prototype 
********************************************/
void MotorInit(void);
void MotorRotateDirection(enum rotate_t direction);
void MotorNextState( void );


#endif  //_MOTOR_H_

