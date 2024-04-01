;
; AssemblerApplication1.asm
;
; Created: 27.01.2024 09:32:05
; Author : iNQU1SITOR
;


; Replace with your application code
start:
	LDI R16,0x0c
	LDI R17,0x0E

	MUL R16,R17

	MOV R26,R0
	MOV R27,R1

	LDI R17,0x09
	EOR R0,R17
	
	ST X,R0
