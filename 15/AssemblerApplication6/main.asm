;
; AssemblerApplication6.asm
;
; Created: 09.04.2024 21:52:37
; Author : iNQU1SITOR
;
	.DEF counter=R16

	.SET first=first_arr*2
	.SET second=second_arr*2

	.DSEG
third_arr: .BYTE 20

	.MACRO GA

	LDI R19,0

	ADD R30,counter
	ADC R31,R19

	.ENDM

	.MACRO LDA

	LDI @0H,HIGH(@1)
	LDI @0l,LOW(@1)

	.ENDM

	.MACRO LPZ

	LDA Z,@1
	GA
	LPM @0,Z

	.ENDM

	.MACRO STA

	ST @0+,@1
	ST @0+,@2

	.ENDM

	.LISTMAC

	.CSEG
start:
	LDA Y,third_arr

	CLR counter

loop:
	CPI counter,15
	BREQ end
	RCALL process_values
	INC counter
	JMP loop

end:
	RET

init_values:
	LPZ R17,first
	LPZ R18,second
	RET

sub_values:
	SUB R17,R18
	CLR R18
	SBCI R18,0
	RET

save_value:
	STA Y,R18,R17
	RET

process_values:
	RCALL init_values
	RCALL sub_values
	RCALL save_value
	RET

first_arr: .DB 0,15,30,45,60,75,90,105,120,135,150,165,180,195,210
second_arr: .DB 210,195,180,165,150,135,120,105,90,75,60,45,30,15,0