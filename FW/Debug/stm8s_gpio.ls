   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
 107                     ; 53 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 107                     ; 54 {
 109                     	switch	.text
 110  0000               _GPIO_DeInit:
 114                     ; 55   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 116  0000 7f            	clr	(x)
 117                     ; 56   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 119  0001 6f02          	clr	(2,x)
 120                     ; 57   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 122  0003 6f03          	clr	(3,x)
 123                     ; 58   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 125  0005 6f04          	clr	(4,x)
 126                     ; 59 }
 129  0007 81            	ret
 369                     ; 71 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 369                     ; 72 {
 370                     	switch	.text
 371  0008               _GPIO_Init:
 373  0008 89            	pushw	x
 374       00000000      OFST:	set	0
 377                     ; 77   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 379                     ; 78   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 381                     ; 81   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 383  0009 7b05          	ld	a,(OFST+5,sp)
 384  000b 43            	cpl	a
 385  000c e404          	and	a,(4,x)
 386  000e e704          	ld	(4,x),a
 387                     ; 87   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 389  0010 7b06          	ld	a,(OFST+6,sp)
 390  0012 a580          	bcp	a,#128
 391  0014 271d          	jreq	L771
 392                     ; 89     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 394  0016 7b06          	ld	a,(OFST+6,sp)
 395  0018 a510          	bcp	a,#16
 396  001a 2706          	jreq	L102
 397                     ; 91       GPIOx->ODR |= (uint8_t)GPIO_Pin;
 399  001c f6            	ld	a,(x)
 400  001d 1a05          	or	a,(OFST+5,sp)
 401  001f f7            	ld	(x),a
 403  0020 2007          	jra	L302
 404  0022               L102:
 405                     ; 95       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 407  0022 1e01          	ldw	x,(OFST+1,sp)
 408  0024 7b05          	ld	a,(OFST+5,sp)
 409  0026 43            	cpl	a
 410  0027 f4            	and	a,(x)
 411  0028 f7            	ld	(x),a
 412  0029               L302:
 413                     ; 98     GPIOx->DDR |= (uint8_t)GPIO_Pin;
 415  0029 1e01          	ldw	x,(OFST+1,sp)
 416  002b e602          	ld	a,(2,x)
 417  002d 1a05          	or	a,(OFST+5,sp)
 418  002f e702          	ld	(2,x),a
 420  0031 2009          	jra	L502
 421  0033               L771:
 422                     ; 103     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 424  0033 1e01          	ldw	x,(OFST+1,sp)
 425  0035 7b05          	ld	a,(OFST+5,sp)
 426  0037 43            	cpl	a
 427  0038 e402          	and	a,(2,x)
 428  003a e702          	ld	(2,x),a
 429  003c               L502:
 430                     ; 110   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 432  003c 7b06          	ld	a,(OFST+6,sp)
 433  003e a540          	bcp	a,#64
 434  0040 270a          	jreq	L702
 435                     ; 112     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 437  0042 1e01          	ldw	x,(OFST+1,sp)
 438  0044 e603          	ld	a,(3,x)
 439  0046 1a05          	or	a,(OFST+5,sp)
 440  0048 e703          	ld	(3,x),a
 442  004a 2009          	jra	L112
 443  004c               L702:
 444                     ; 116     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 446  004c 1e01          	ldw	x,(OFST+1,sp)
 447  004e 7b05          	ld	a,(OFST+5,sp)
 448  0050 43            	cpl	a
 449  0051 e403          	and	a,(3,x)
 450  0053 e703          	ld	(3,x),a
 451  0055               L112:
 452                     ; 123   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 454  0055 7b06          	ld	a,(OFST+6,sp)
 455  0057 a520          	bcp	a,#32
 456  0059 270a          	jreq	L312
 457                     ; 125     GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 459  005b 1e01          	ldw	x,(OFST+1,sp)
 460  005d e604          	ld	a,(4,x)
 461  005f 1a05          	or	a,(OFST+5,sp)
 462  0061 e704          	ld	(4,x),a
 464  0063 2009          	jra	L512
 465  0065               L312:
 466                     ; 129     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 468  0065 1e01          	ldw	x,(OFST+1,sp)
 469  0067 7b05          	ld	a,(OFST+5,sp)
 470  0069 43            	cpl	a
 471  006a e404          	and	a,(4,x)
 472  006c e704          	ld	(4,x),a
 473  006e               L512:
 474                     ; 131 }
 477  006e 85            	popw	x
 478  006f 81            	ret
 522                     ; 141 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 522                     ; 142 {
 523                     	switch	.text
 524  0070               _GPIO_Write:
 526  0070 89            	pushw	x
 527       00000000      OFST:	set	0
 530                     ; 143   GPIOx->ODR = PortVal;
 532  0071 7b05          	ld	a,(OFST+5,sp)
 533  0073 1e01          	ldw	x,(OFST+1,sp)
 534  0075 f7            	ld	(x),a
 535                     ; 144 }
 538  0076 85            	popw	x
 539  0077 81            	ret
 586                     ; 154 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 586                     ; 155 {
 587                     	switch	.text
 588  0078               _GPIO_WriteHigh:
 590  0078 89            	pushw	x
 591       00000000      OFST:	set	0
 594                     ; 156   GPIOx->ODR |= (uint8_t)PortPins;
 596  0079 f6            	ld	a,(x)
 597  007a 1a05          	or	a,(OFST+5,sp)
 598  007c f7            	ld	(x),a
 599                     ; 157 }
 602  007d 85            	popw	x
 603  007e 81            	ret
 650                     ; 167 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 650                     ; 168 {
 651                     	switch	.text
 652  007f               _GPIO_WriteLow:
 654  007f 89            	pushw	x
 655       00000000      OFST:	set	0
 658                     ; 169   GPIOx->ODR &= (uint8_t)(~PortPins);
 660  0080 7b05          	ld	a,(OFST+5,sp)
 661  0082 43            	cpl	a
 662  0083 f4            	and	a,(x)
 663  0084 f7            	ld	(x),a
 664                     ; 170 }
 667  0085 85            	popw	x
 668  0086 81            	ret
 715                     ; 180 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 715                     ; 181 {
 716                     	switch	.text
 717  0087               _GPIO_WriteReverse:
 719  0087 89            	pushw	x
 720       00000000      OFST:	set	0
 723                     ; 182   GPIOx->ODR ^= (uint8_t)PortPins;
 725  0088 f6            	ld	a,(x)
 726  0089 1805          	xor	a,(OFST+5,sp)
 727  008b f7            	ld	(x),a
 728                     ; 183 }
 731  008c 85            	popw	x
 732  008d 81            	ret
 770                     ; 191 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 770                     ; 192 {
 771                     	switch	.text
 772  008e               _GPIO_ReadOutputData:
 776                     ; 193   return ((uint8_t)GPIOx->ODR);
 778  008e f6            	ld	a,(x)
 781  008f 81            	ret
 818                     ; 202 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 818                     ; 203 {
 819                     	switch	.text
 820  0090               _GPIO_ReadInputData:
 824                     ; 204   return ((uint8_t)GPIOx->IDR);
 826  0090 e601          	ld	a,(1,x)
 829  0092 81            	ret
 897                     ; 213 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 897                     ; 214 {
 898                     	switch	.text
 899  0093               _GPIO_ReadInputPin:
 901  0093 89            	pushw	x
 902       00000000      OFST:	set	0
 905                     ; 215   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 907  0094 e601          	ld	a,(1,x)
 908  0096 1405          	and	a,(OFST+5,sp)
 911  0098 85            	popw	x
 912  0099 81            	ret
 990                     ; 225 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 990                     ; 226 {
 991                     	switch	.text
 992  009a               _GPIO_ExternalPullUpConfig:
 994  009a 89            	pushw	x
 995       00000000      OFST:	set	0
 998                     ; 228   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1000                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1002                     ; 231   if (NewState != DISABLE) /* External Pull-Up Set*/
1004  009b 0d06          	tnz	(OFST+6,sp)
1005  009d 2708          	jreq	L174
1006                     ; 233     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1008  009f e603          	ld	a,(3,x)
1009  00a1 1a05          	or	a,(OFST+5,sp)
1010  00a3 e703          	ld	(3,x),a
1012  00a5 2009          	jra	L374
1013  00a7               L174:
1014                     ; 236     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1016  00a7 1e01          	ldw	x,(OFST+1,sp)
1017  00a9 7b05          	ld	a,(OFST+5,sp)
1018  00ab 43            	cpl	a
1019  00ac e403          	and	a,(3,x)
1020  00ae e703          	ld	(3,x),a
1021  00b0               L374:
1022                     ; 238 }
1025  00b0 85            	popw	x
1026  00b1 81            	ret
1039                     	xdef	_GPIO_ExternalPullUpConfig
1040                     	xdef	_GPIO_ReadInputPin
1041                     	xdef	_GPIO_ReadOutputData
1042                     	xdef	_GPIO_ReadInputData
1043                     	xdef	_GPIO_WriteReverse
1044                     	xdef	_GPIO_WriteLow
1045                     	xdef	_GPIO_WriteHigh
1046                     	xdef	_GPIO_Write
1047                     	xdef	_GPIO_Init
1048                     	xdef	_GPIO_DeInit
1067                     	end
