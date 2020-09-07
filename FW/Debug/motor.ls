   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
  44                     ; 69 void MotorInit(void)
  44                     ; 70 {
  46                     	switch	.text
  47  0000               _MotorInit:
  51                     ; 73 	MotorGpioInit();
  53  0000 cd00cb        	call	L11_MotorGpioInit
  55                     ; 75 	MotorRotateDirection(ROTATE_STOP);
  57  0003 4f            	clr	a
  58  0004 ad05          	call	_MotorRotateDirection
  60                     ; 76 	order_cnter = 0;
  62  0006 725f0000      	clr	L5_order_cnter
  63                     ; 77 }
  66  000a 81            	ret
 130                     ; 90 void MotorRotateDirection(enum rotate_t direction){
 131                     	switch	.text
 132  000b               _MotorRotateDirection:
 134  000b 88            	push	a
 135       00000000      OFST:	set	0
 138                     ; 91 	if(ROTATE_CLK == direction){
 140  000c a101          	cp	a,#1
 141  000e 2612          	jrne	L16
 142                     ; 92 		orders[0] = MOTOR_PHASE_1;
 144  0010 35010001      	mov	L3_orders,#1
 145                     ; 93 		orders[1] = MOTOR_PHASE_2;
 147  0014 35020002      	mov	L3_orders+1,#2
 148                     ; 94 		orders[2] = MOTOR_PHASE_3;
 150  0018 35030003      	mov	L3_orders+2,#3
 151                     ; 95 		orders[3] = MOTOR_PHASE_4;
 153  001c 35040004      	mov	L3_orders+3,#4
 155  0020 2028          	jra	L36
 156  0022               L16:
 157                     ; 96 	} else if (ROTATE_CLKWISE == direction){
 159  0022 7b01          	ld	a,(OFST+1,sp)
 160  0024 a102          	cp	a,#2
 161  0026 2612          	jrne	L56
 162                     ; 97 		orders[0] = MOTOR_PHASE_4;
 164  0028 35040001      	mov	L3_orders,#4
 165                     ; 98 		orders[1] = MOTOR_PHASE_3;
 167  002c 35030002      	mov	L3_orders+1,#3
 168                     ; 99 		orders[2] = MOTOR_PHASE_2;
 170  0030 35020003      	mov	L3_orders+2,#2
 171                     ; 100 		orders[3] = MOTOR_PHASE_1;
 173  0034 35010004      	mov	L3_orders+3,#1
 175  0038 2010          	jra	L36
 176  003a               L56:
 177                     ; 102 		orders[0] = MOTOR_LOOP_OFF;
 179  003a 725f0001      	clr	L3_orders
 180                     ; 103 		orders[1] = MOTOR_LOOP_OFF;
 182  003e 725f0002      	clr	L3_orders+1
 183                     ; 104 		orders[2] = MOTOR_LOOP_OFF;
 185  0042 725f0003      	clr	L3_orders+2
 186                     ; 105 		orders[3] = MOTOR_LOOP_OFF;
 188  0046 725f0004      	clr	L3_orders+3
 189  004a               L36:
 190                     ; 107 }
 193  004a 84            	pop	a
 194  004b 81            	ret
 220                     ; 122 void MotorNextState( void ){
 221                     	switch	.text
 222  004c               _MotorNextState:
 226                     ; 124 	order_cnter++;
 228  004c 725c0000      	inc	L5_order_cnter
 229                     ; 125 	if(order_cnter == 4) {
 231  0050 c60000        	ld	a,L5_order_cnter
 232  0053 a104          	cp	a,#4
 233  0055 2604          	jrne	L101
 234                     ; 126 		order_cnter = 0;
 236  0057 725f0000      	clr	L5_order_cnter
 237  005b               L101:
 238                     ; 129 	MotorApplyState(orders[order_cnter]);	
 240  005b c60000        	ld	a,L5_order_cnter
 241  005e 5f            	clrw	x
 242  005f 97            	ld	xl,a
 243  0060 d60001        	ld	a,(L3_orders,x)
 244  0063 ad01          	call	L7_MotorApplyState
 246                     ; 130 }
 249  0065 81            	ret
 325                     ; 143 static void MotorApplyState(enum motor_state_t state)
 325                     ; 144 {
 326                     	switch	.text
 327  0066               L7_MotorApplyState:
 331                     ; 146 	switch(state){
 334                     ; 177 						 break;
 335  0066 4a            	dec	a
 336  0067 271b          	jreq	L301
 337  0069 4a            	dec	a
 338  006a 272a          	jreq	L501
 339  006c 4a            	dec	a
 340  006d 2739          	jreq	L701
 341  006f 4a            	dec	a
 342  0070 2748          	jreq	L111
 343  0072               L311:
 344                     ; 172 		default:
 344                     ; 173 						 PINA_PORT->ODR &= ~PINA_PIN;
 346  0072 721f500a      	bres	20490,#7
 347                     ; 174 						 PINB_PORT->ODR &= ~PINB_PIN;	
 349  0076 7213500f      	bres	20495,#1
 350                     ; 175 						 PINC_PORT->ODR &= ~PINC_PIN;
 352  007a 7215500f      	bres	20495,#2
 353                     ; 176 						 PIND_PORT->ODR &= ~PIND_PIN;
 355  007e 7217500f      	bres	20495,#3
 356                     ; 177 						 break;
 358  0082 2046          	jra	L351
 359  0084               L301:
 360                     ; 147 		case MOTOR_PHASE_1: 
 360                     ; 148 												 PINC_PORT->ODR &= ~PINC_PIN;
 362  0084 7215500f      	bres	20495,#2
 363                     ; 149 												 PINB_PORT->ODR &= ~PINB_PIN;
 365  0088 7213500f      	bres	20495,#1
 366                     ; 150 												 PINA_PORT->ODR |= PINA_PIN;
 368  008c 721e500a      	bset	20490,#7
 369                     ; 151 												 PIND_PORT->ODR |= PIND_PIN;
 371  0090 7216500f      	bset	20495,#3
 372                     ; 152 												 break;
 374  0094 2034          	jra	L351
 375  0096               L501:
 376                     ; 153 		case MOTOR_PHASE_2: 
 376                     ; 154 												 PINB_PORT->ODR &= ~PINB_PIN;	
 378  0096 7213500f      	bres	20495,#1
 379                     ; 155 												 PIND_PORT->ODR &= ~PIND_PIN;
 381  009a 7217500f      	bres	20495,#3
 382                     ; 156 												 PINA_PORT->ODR |= PINA_PIN;
 384  009e 721e500a      	bset	20490,#7
 385                     ; 157 												 PINC_PORT->ODR |= PINC_PIN;
 387  00a2 7214500f      	bset	20495,#2
 388                     ; 159 												 break;
 390  00a6 2022          	jra	L351
 391  00a8               L701:
 392                     ; 160 		case MOTOR_PHASE_3:
 392                     ; 161 												 PINA_PORT->ODR &= ~PINA_PIN;
 394  00a8 721f500a      	bres	20490,#7
 395                     ; 162 												 PIND_PORT->ODR &= ~PIND_PIN;
 397  00ac 7217500f      	bres	20495,#3
 398                     ; 163 												 PINB_PORT->ODR |= PINB_PIN;		
 400  00b0 7212500f      	bset	20495,#1
 401                     ; 164 												 PINC_PORT->ODR |= PINC_PIN;	
 403  00b4 7214500f      	bset	20495,#2
 404                     ; 165 												 break;												 
 406  00b8 2010          	jra	L351
 407  00ba               L111:
 408                     ; 166 		case MOTOR_PHASE_4:
 408                     ; 167 												 PINA_PORT->ODR &= ~PINA_PIN;	
 410  00ba 721f500a      	bres	20490,#7
 411                     ; 168 												 PINC_PORT->ODR &= ~PINC_PIN;
 413  00be 7215500f      	bres	20495,#2
 414                     ; 169 												 PIND_PORT->ODR |= PIND_PIN;	
 416  00c2 7216500f      	bset	20495,#3
 417                     ; 170 												 PINB_PORT->ODR |= PINB_PIN;	
 419  00c6 7212500f      	bset	20495,#1
 420                     ; 171 												 break;
 422  00ca               L351:
 423                     ; 180 }
 426  00ca 81            	ret
 449                     ; 193 static void MotorGpioInit( void )
 449                     ; 194 {
 450                     	switch	.text
 451  00cb               L11_MotorGpioInit:
 455                     ; 196 	PINA_PORT->ODR &= ~PINA_PIN;
 457  00cb 721f500a      	bres	20490,#7
 458                     ; 197 	PINB_PORT->ODR &= ~PINB_PIN;
 460  00cf 7213500f      	bres	20495,#1
 461                     ; 198 	PINC_PORT->ODR &= ~PINC_PIN;
 463  00d3 7215500f      	bres	20495,#2
 464                     ; 199 	PIND_PORT->ODR &= ~PIND_PIN;
 466  00d7 7217500f      	bres	20495,#3
 467                     ; 201 	PINA_PORT->DDR |= PINA_PIN;
 469  00db 721e500c      	bset	20492,#7
 470                     ; 202 	PINB_PORT->DDR |= PINB_PIN;
 472  00df 72125011      	bset	20497,#1
 473                     ; 203 	PINC_PORT->DDR |= PINC_PIN;
 475  00e3 72145011      	bset	20497,#2
 476                     ; 204 	PIND_PORT->DDR |= PIND_PIN;
 478  00e7 72165011      	bset	20497,#3
 479                     ; 206 	PINA_PORT->CR1 |= PINA_PIN;
 481  00eb 721e500d      	bset	20493,#7
 482                     ; 207 	PINB_PORT->CR1 |= PINB_PIN;
 484  00ef 72125012      	bset	20498,#1
 485                     ; 208 	PINC_PORT->CR1 |= PINC_PIN;
 487  00f3 72145012      	bset	20498,#2
 488                     ; 209 	PIND_PORT->CR1 |= PIND_PIN;
 490  00f7 72165012      	bset	20498,#3
 491                     ; 212 	PINA_PORT->CR2 &= ~PINA_PIN;
 493  00fb 721f500e      	bres	20494,#7
 494                     ; 213 	PINB_PORT->CR2 &= ~PINB_PIN;
 496  00ff 72135013      	bres	20499,#1
 497                     ; 214 	PINC_PORT->CR2 &= ~PINC_PIN;
 499  0103 72155013      	bres	20499,#2
 500                     ; 215 	PIND_PORT->CR2 &= ~PIND_PIN;
 502  0107 72175013      	bres	20499,#3
 503                     ; 216 }
 506  010b 81            	ret
 540                     	switch	.bss
 541  0000               L5_order_cnter:
 542  0000 00            	ds.b	1
 543  0001               L3_orders:
 544  0001 00000000      	ds.b	4
 545                     	xdef	_MotorNextState
 546                     	xdef	_MotorRotateDirection
 547                     	xdef	_MotorInit
 567                     	end
