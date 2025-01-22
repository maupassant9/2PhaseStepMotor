   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
  13                     	xref	_dly
  46                     ; 10 void main( void )
  46                     ; 11 {
  48                     	switch	.text
  49  0000               _main:
  53                     ; 12 	MotorInit();
  55  0000 cd0000        	call	_MotorInit
  57                     ; 14 	MotorRotateDirection(ROTATE_CLK);
  59  0003 a601          	ld	a,#1
  60  0005 cd0000        	call	_MotorRotateDirection
  62  0008               L12:
  63                     ; 17 		MotorNextState();
  65  0008 cd0000        	call	_MotorNextState
  67                     ; 18 		dly();
  69  000b ad02          	call	_dly
  72  000d 20f9          	jra	L12
 104                     .const:	section	.text
 105  0000               L01:
 106  0000 00000fff      	dc.l	4095
 107                     ; 23 void dly()
 107                     ; 24 {
 108                     	switch	.text
 109  000f               _dly:
 111  000f 5204          	subw	sp,#4
 112       00000004      OFST:	set	4
 115                     ; 26 	for(cnt = 0; cnt < 0xfff; cnt++);
 117  0011 ae0000        	ldw	x,#0
 118  0014 1f03          	ldw	(OFST-1,sp),x
 119  0016 ae0000        	ldw	x,#0
 120  0019 1f01          	ldw	(OFST-3,sp),x
 122  001b               L14:
 126  001b 96            	ldw	x,sp
 127  001c 1c0001        	addw	x,#OFST-3
 128  001f a601          	ld	a,#1
 129  0021 cd0000        	call	c_lgadc
 134  0024 96            	ldw	x,sp
 135  0025 1c0001        	addw	x,#OFST-3
 136  0028 cd0000        	call	c_ltor
 138  002b ae0000        	ldw	x,#L01
 139  002e cd0000        	call	c_lcmp
 141  0031 25e8          	jrult	L14
 142                     ; 27 }
 145  0033 5b04          	addw	sp,#4
 146  0035 81            	ret
 159                     	xdef	_dly
 160                     	xdef	_main
 161                     	xref	_MotorNextState
 162                     	xref	_MotorRotateDirection
 163                     	xref	_MotorInit
 182                     	xref	c_lcmp
 183                     	xref	c_ltor
 184                     	xref	c_lgadc
 185                     	end
