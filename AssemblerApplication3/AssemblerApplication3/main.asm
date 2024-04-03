;
; AssemblerApplication3.asm
;
; Created: 31.03.2024 13:43:04
; Author : iNQU1SITOR
;
					.DSEG
first_arr:		.BYTE				10;�������� 10 ���� �� ������ ������
second_arr:	.BYTE				10;�������� 10 ���� �� ������ ������
third_arr:		.BYTE				20;�������� 20 ���� �� ������ ������

					.DEF					counter=R16;������ ��� �������� R16

;������ ���������� ������ ������� � X/Y/Z
					.MACRO			LOAD_ADDR
					LDI					@0H, HIGH(@1)
					LDI					@0L, LOW(@1)
					.ENDM
;-----------------------------------------------

;������ ���������� ������� "����������" �������
					.MACRO			FILLARR
					RCALL				clear_counter ;���������� ����������� ��������� �������
					RCALL				load_max_value

					LOAD_ADDR	X,@0

loop:
					RCALL				compare_counter
					BREQ				end
					RCALL				process_arr
					RCALL				inc_counter
					JMP					loop

;��������� ������������ ��������� �������� �������� ������� � R17
load_max_value:
					LDI					R17,0xFF ;������������ �������� �������� �������
					RET
;----------------------------------------------

;��������������� ������������ ������
process_arr:
					ST					X+,R17
					SUBI				R17,15
					RET
;---------------------------------------------

end:
					.ENDM
;-----------------------------------------------

					.LISTMAC;�������� ��������� �������� ��� ��������

;���� ���������
					.CSEG
start:
					RCALL				fill_arrs
					RCALL				fill_third_arr
					RET
;-----------------------------------------

;��������� ������� �������
fill_arrs:
					FILLARR			first_arr
					FILLARR			second_arr
					RET
;------------------------------------------

;��������� ������ ������
fill_third_arr:
					RCALL clear_counter
					CLR					R17 ;������ 0

					RCALL load_addrs

loop:
					RCALL				compare_counter
					BREQ				end
					RCALL				process_arrs
					RCALL				inc_counter
					JMP					loop

end:
					RET
;----------------------------------------------

;��������� �������� �� �������� �� ������� Y � Z � R18 � R19 ��������������
load_values_from_arrs:
					LD					R18,Y+
					LD					R19,Z+
					RET
;-------------------------------------------

;��������� R19:R18 �� ������ X
save_value_to_arr:
					ST					X+,R19
					ST					X+,R18
					RET
;---------------------------------------------

;��������� R18 � R19 � ������ ������������, �� ������ R19:R18
sum_values:
					ADD				R18,R19
					CLR					R19
					ADC					R19,R17
					RET
;--------------------------------------------------

;��������� ������ �������� � Y � Z
load_addrs:
					LOAD_ADDR Y,first_arr
					LOAD_ADDR Z,second_arr
					RET
;--------------------------------------------------

;��������������� ������������ �������
process_arrs:
					RCALL				load_values_from_arrs
					RCALL				sum_values
					RCALL				save_value_to_arr
					RET
;-------------------------------------------------

;�������� ������� ����������� ���������
clear_counter:
					CLR					counter
					RET
;---------------------------------------------------

;���������� ������� � 10
compare_counter:
					CPI					counter,10
					RET
;--------------------------------------------------

;����������� ������� ��������� ������� �� 1
inc_counter:
					INC counter
					RET
;-------------------------------------------------