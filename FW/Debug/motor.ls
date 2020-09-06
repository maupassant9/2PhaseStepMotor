   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  43                     ; 66 void MotorInit(void)
  43                     ; 67 {
  45                     	switch	.text
  46  0000               _MotorInit:
  50                     ; 71 	MotorRotateDirection(ROTATE_STOP);
  52  0000 4f            	clr	a
  53  0001 ad05          	call	_MotorRotateDirection
  55                     ; 72 	order_cnter = 0;
  57  0003 725f0000      	clr	L5_order_cnter
  58                     ; 73 }
  61  0007 81            	ret
 125                     ; 86 void MotorRotateDirection(enum rotate_t direction){
 126                     	switch	.text
 127  0008               _MotorRotateDirection:
 129  0008 88            	push	a
 130       00000000      OFST:	set	0
 133                     ; 87 	if(ROTATE_CLK == direction){
 135  0009 a101          	cp	a,#1
 136  000b 2612          	jrne	L16
 137                     ; 88 		orders[0] = MOTOR_LOOPA_POS;
 139  000d 35010001      	mov	L3_orders,#1
 140                     ; 89 		orders[1] = MOTOR_LOOPB_POS;
 142  0011 35030002      	mov	L3_orders+1,#3
 143                     ; 90 		orders[2] = MOTOR_LOOPA_NEG;
 145  0015 35020003      	mov	L3_orders+2,#2
 146                     ; 91 		orders[3] = MOTOR_LOOPB_NEG;
 148  0019 35040004      	mov	L3_orders+3,#4
 150  001d 2028          	jra	L36
 151  001f               L16:
 152                     ; 92 	} else if (ROTATE_CLKWISE == direction){
 154  001f 7b01          	ld	a,(OFST+1,sp)
 155  0021 a102          	cp	a,#2
 156  0023 2612          	jrne	L56
 157                     ; 93 		orders[0] = MOTOR_LOOPB_POS;
 159  0025 35030001      	mov	L3_orders,#3
 160                     ; 94 		orders[1] = MOTOR_LOOPA_POS;
 162  0029 35010002      	mov	L3_orders+1,#1
 163                     ; 95 		orders[2] = MOTOR_LOOPB_NEG;
 165  002d 35040003      	mov	L3_orders+2,#4
 166                     ; 96 		orders[3] = MOTOR_LOOPA_NEG;
 168  0031 35020004      	mov	L3_orders+3,#2
 170  0035 2010          	jra	L36
 171  0037               L56:
 172                     ; 98 		orders[0] = MOTOR_LOOP_OFF;
 174  0037 725f0001      	clr	L3_orders
 175                     ; 99 		orders[1] = MOTOR_LOOP_OFF;
 177  003b 725f0002      	clr	L3_orders+1
 178                     ; 100 		orders[2] = MOTOR_LOOP_OFF;
 180  003f 725f0003      	clr	L3_orders+2
 181                     ; 101 		orders[3] = MOTOR_LOOP_OFF;
 183  0043 725f0004      	clr	L3_orders+3
 184  0047               L36:
 185                     ; 103 }
 188  0047 84            	pop	a
 189  0048 81            	ret
 215                     ; 118 void MotorNextState( void ){
 216                     	switch	.text
 217  0049               _MotorNextState:
 221                     ; 120 	order_cnter++;
 223  0049 725c0000      	inc	L5_order_cnter
 224                     ; 121 	if(order_cnter == 4) {
 226  004d c60000        	ld	a,L5_order_cnter
 227  0050 a104          	cp	a,#4
 228  0052 2604          	jrne	L101
 229                     ; 122 		order_cnter = 0;
 231  0054 725f0000      	clr	L5_order_cnter
 232  0058               L101:
 233                     ; 125 	MotorApplyState(orders[order_cnter]);	
 235  0058 c60000        	ld	a,L5_order_cnter
 236  005b 5f            	clrw	x
 237  005c 97            	ld	xl,a
 238  005d d60001        	ld	a,(L3_orders,x)
 239  0060 ad01          	call	L7_MotorApplyState
 241                     ; 126 }
 244  0062 81            	ret
 320                     ; 139 static void MotorApplyState(enum motor_state_t state)
 320                     ; 140 {
 321                     	switch	.text
 322  0063               L7_MotorApplyState:
 326                     ; 142 	switch(state){
 329                     ; 172 						 break;
 330  0063 4a            	dec	a
 331  0064 271b          	jreq	L301
 332  0066 4a            	dec	a
 333  0067 272a          	jreq	L501
 334  0069 4a            	dec	a
 335  006a 2739          	jreq	L701
 336  006c 4a            	dec	a
 337  006d 2748          	jreq	L111
 338  006f               L311:
 339                     ; 167 		default:
 339                     ; 168 						 PINA_PORT->ODR &= ~PINA_PIN;
 341  006f 721f500a      	bres	20490,#7
 342                     ; 169 						 PINB_PORT->ODR &= ~PINB_PIN;	
 344  0073 7211500f      	bres	20495,#0
 345                     ; 170 						 PINC_PORT->ODR &= ~PINC_PIN;
 347  0077 7213500f      	bres	20495,#1
 348                     ; 171 						 PIND_PORT->ODR &= ~PIND_PIN;
 350  007b 7215500f      	bres	20495,#2
 351                     ; 172 						 break;
 353  007f 2046          	jra	L351
 354  0081               L301:
 355                     ; 143 		case MOTOR_LOOPA_POS: 
 355                     ; 144 												 PINC_PORT->ODR &= ~PINC_PIN;
 357  0081 7213500f      	bres	20495,#1
 358                     ; 145 												 PIND_PORT->ODR &= ~PIND_PIN;
 360  0085 7215500f      	bres	20495,#2
 361                     ; 146 												 PINB_PORT->ODR &= ~PINB_PIN;
 363  0089 7211500f      	bres	20495,#0
 364                     ; 147 												 PINA_PORT->ODR |= PINA_PIN;	
 366  008d 721e500a      	bset	20490,#7
 367                     ; 148 												 break;
 369  0091 2034          	jra	L351
 370  0093               L501:
 371                     ; 149 		case MOTOR_LOOPA_NEG: 
 371                     ; 150 												 PINC_PORT->ODR &= ~PINC_PIN;
 373  0093 7213500f      	bres	20495,#1
 374                     ; 151 												 PIND_PORT->ODR &= ~PIND_PIN;
 376  0097 7215500f      	bres	20495,#2
 377                     ; 152 												 PINA_PORT->ODR &= ~PINA_PIN;
 379  009b 721f500a      	bres	20490,#7
 380                     ; 153 												 PINB_PORT->ODR |= PINB_PIN;	
 382  009f 7210500f      	bset	20495,#0
 383                     ; 154 												 break;
 385  00a3 2022          	jra	L351
 386  00a5               L701:
 387                     ; 155 		case MOTOR_LOOPB_POS:
 387                     ; 156 												 PINA_PORT->ODR &= ~PINA_PIN;
 389  00a5 721f500a      	bres	20490,#7
 390                     ; 157 												 PINB_PORT->ODR &= ~PINB_PIN;		
 392  00a9 7211500f      	bres	20495,#0
 393                     ; 158 												 PIND_PORT->ODR &= ~PIND_PIN;
 395  00ad 7215500f      	bres	20495,#2
 396                     ; 159 												 PINC_PORT->ODR |= PINC_PIN;	
 398  00b1 7212500f      	bset	20495,#1
 399                     ; 160 												 break;												 
 401  00b5 2010          	jra	L351
 402  00b7               L111:
 403                     ; 161 		case MOTOR_LOOPB_NEG:
 403                     ; 162 												 PINA_PORT->ODR &= ~PINA_PIN;
 405  00b7 721f500a      	bres	20490,#7
 406                     ; 163 												 PINB_PORT->ODR &= ~PINB_PIN;		
 408  00bb 7211500f      	bres	20495,#0
 409                     ; 164 												 PINC_PORT->ODR &= ~PINC_PIN;
 411  00bf 7213500f      	bres	20495,#1
 412                     ; 165 												 PIND_PORT->ODR |= PIND_PIN;	
 414  00c3 7214500f      	bset	20495,#2
 415                     ; 166 												 break;
 417  00c7               L351:
 418                     ; 175 }
 421  00c7 81            	ret
 444                     ; 188 static void MotorGpioInit( void )
 444                     ; 189 {
 445                     	switch	.text
 446  00c8               L11_MotorGpioInit:
 450                     ; 191 	PINA_PORT->ODR &= ~PINA_PIN;
 452  00c8 721f500a      	bres	20490,#7
 453                     ; 192 	PINB_PORT->ODR &= ~PINB_PIN;
 455  00cc 7211500f      	bres	20495,#0
 456                     ; 193 	PINC_PORT->ODR &= ~PINC_PIN;
 458  00d0 7213500f      	bres	20495,#1
 459                     ; 194 	PIND_PORT->ODR &= ~PIND_PIN;
 461  00d4 7215500f      	bres	20495,#2
 462                     ; 196 	PINA_PORT->DDR |= PINA_PIN;
 464  00d8 721e500c      	bset	20492,#7
 465                     ; 197 	PINB_PORT->DDR |= PINB_PIN;
 467  00dc 72105011      	bset	20497,#0
 468                     ; 198 	PINC_PORT->DDR |= PINC_PIN;
 470  00e0 72125011      	bset	20497,#1
 471                     ; 199 	PIND_PORT->DDR |= PIND_PIN;
 473  00e4 72145011      	bset	20497,#2
 474                     ; 201 	PINA_PORT->CR1 |= PINA_PIN;
 476  00e8 721e500d      	bset	20493,#7
 477                     ; 202 	PINB_PORT->CR1 |= PINB_PIN;
 479  00ec 72105012      	bset	20498,#0
 480                     ; 203 	PINC_PORT->CR1 |= PINC_PIN;
 482  00f0 72125012      	bset	20498,#1
 483                     ; 204 	PIND_PORT->CR1 |= PIND_PIN;
 485  00f4 72145012      	bset	20498,#2
 486                     ; 207 	PINA_PORT->CR2 &= ~PINA_PIN;
 488  00f8 721f500e      	bres	20494,#7
 489                     ; 208 	PINB_PORT->CR2 &= ~PINB_PIN;
 491  00fc 72115013      	bres	20499,#0
 492                     ; 209 	PINC_PORT->CR2 &= ~PINC_PIN;
 494  0100 72135013      	bres	20499,#1
 495                     ; 210 	PIND_PORT->CR2 &= ~PIND_PIN;
 497  0104 72155013      	bres	20499,#2
 498                     ; 211 }
 501  0108 81            	ret
 535                     	switch	.bss
 536  0000               L5_order_cnter:
 537  0000 00            	ds.b	1
 538  0001               L3_orders:
 539  0001 00000000      	ds.b	4
 540                     	xdef	_MotorNextState
 541                     	xdef	_MotorRotateDirection
 542                     	xdef	_MotorInit
 562                     	end
