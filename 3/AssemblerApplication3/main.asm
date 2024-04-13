;
; AssemblerApplication3.asm
;
; Created: 31.03.2024 13:43:04
; Author : iNQU1SITOR
;
					.DSEG
first_arr:		.BYTE				10;выделяем 10 байт на первый массив
second_arr:	.BYTE				10;выделяем 10 байт на второй массив
third_arr:		.BYTE				20;выделяем 20 байт на третий массив

					.DEF					counter=R16;задаем имя регистру R16

;макрос сохранения адреса массива в X/Y/Z
					.MACRO			LOAD_ADDR
					LDI					@0H, HIGH(@1)
					LDI					@0L, LOW(@1)
					.ENDM
;-----------------------------------------------

;макрос заполнения массива "случайными" числами
					.MACRO			FILLARR
					RCALL				clear_counter ;количество заполненных элементов массива
					RCALL				load_max_value

					LOAD_ADDR	X,@0

loop:
					RCALL				compare_counter
					BREQ				end
					RCALL				process_arr
					RCALL				inc_counter
					JMP					loop

;сохраняем максимальное возможное значение элемента массива в R17
load_max_value:
					LDI					R17,0xFF ;максимальное значение элемента массива
					RET
;----------------------------------------------

;непосредственно обрабатываем массив
process_arr:
					ST					X+,R17
					SUBI				R17,15
					RET
;---------------------------------------------

end:
					.ENDM
;-----------------------------------------------

					.LISTMAC;включаем генерацию листинга для макросов

;сама программа
					.CSEG
start:
					RCALL				fill_arrs
					RCALL				fill_third_arr
					RET
;-----------------------------------------

;заполняем массивы данными
fill_arrs:
					FILLARR			first_arr
					FILLARR			second_arr
					RET
;------------------------------------------

;заполняем третий массив
fill_third_arr:
					RCALL clear_counter
					CLR					R17 ;всегда 0

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

;загружаем значения из массивов по аддресу Y и Z в R18 и R19 соответственно
load_values_from_arrs:
					LD					R18,Y+
					LD					R19,Z+
					RET
;-------------------------------------------

;сохраняет R19:R18 по адресу X
save_value_to_arr:
					ST					X+,R19
					ST					X+,R18
					RET
;---------------------------------------------

;суммируем R18 и R19 с учетом переполнения, на выходе R19:R18
sum_values:
					ADD				R18,R19
					CLR					R19
					ADC					R19,R17
					RET
;--------------------------------------------------

;загружаем адреса массивов в Y и Z
load_addrs:
					LOAD_ADDR Y,first_arr
					LOAD_ADDR Z,second_arr
					RET
;--------------------------------------------------

;непосредственно обрабатываем массивы
process_arrs:
					RCALL				load_values_from_arrs
					RCALL				sum_values
					RCALL				save_value_to_arr
					RET
;-------------------------------------------------

;обнуляем счетчик заполненных элементов
clear_counter:
					CLR					counter
					RET
;---------------------------------------------------

;сравниваем счетчик с 10
compare_counter:
					CPI					counter,10
					RET
;--------------------------------------------------

;увеличиваем счетчик элементов массива на 1
inc_counter:
					INC counter
					RET
;-------------------------------------------------