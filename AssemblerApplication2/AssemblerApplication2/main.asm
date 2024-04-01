;
; AssemblerApplication2.asm
;
; Created: 19.03.2024 14:20:22
; Author : iNQU1SITOR
;


; Replace with your application code
start:

	ldi r16, 0x12
	ldi r17, 0xC1
	ldi r18, 209
	sub r17, r18
	clr r19
	sbc r16,  r19
    rjmp start