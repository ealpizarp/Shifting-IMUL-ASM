; ==========Costa Rica Institute of Technology===========
; Authors: Eric Alpizar
;		   Rodrigo Espinach
;		   Jimmy Salas
; Last date modified: 11/12/2020


;-----------------------------------------------------------------------------
; _CLI PROC
; Calculates the multiplication of to given 8 bit numbers
; Recieves: nothing
; Returns:	AL = multiplicand
;			BL = multiplier
;-----------------------------------------------------------------------------

include C:\Irvine\Irvine32.inc
include cli.inc

.data

welcome_message BYTE "----------Welcome to the uint8_mult algorithm----------", 0				;The welcome message is stored
prompt_1 BYTE "Please enter the multiplicand: ", 0												; Prompts are saved
prompt_2 BYTE "Please enter the multiplier: ", 0

error_message_multiplicand BYTE "Error with the multiplicand please enter the number again",0		;error message for multiplicand
error_message_multiplier BYTE "Error with the multiplier please enter the number again",0			;error message for multiplier
multiplicand WORD ?
multiplier WORD ?

.code

_cli PROC



_clear_flags MACRO 
	xor eax, eax
	OR AL, 1
	CLC
ENDM

welcome:
	mov edx, OFFSET welcome_message																;the welcolme message is moved to edx
	call WriteString																			;the message is printed in console using Irvine library
	call CrLf																					;A endline is made on console
	call CrLf

insert_multiplicand:
	_clear_flags
	mov edx, OFFSET prompt_1																	
	call WriteString
	CALL ReadInt																				;A number is requested to the user in console
	mov multiplicand, AX
	cmp multiplicand, 255																		;the low 8 bit register is taken
	jbe insert_multiplier
	jmp error_multiplicand
	

insert_multiplier:
	_clear_flags
	mov edx, OFFSET prompt_2																
	call WriteString
	CALL ReadInt																				;the multiplier is read from console
	mov multiplier, AX
	cmp multiplier, 255																			;check the multiplier is a number of 8 bits at most
	jbe ready_for_mult
	CALL CrLf																					;the cli is excecuted and parameters are asked to the user
	jmp error_multiplier

error_multiplicand:
	mov edx, OFFSET error_message_multiplicand													;the error_message_multiplicand is moved to edx
	call WriteString
	call CrLf																					;A endline is made on console
	call CrLf

	jmp insert_multiplicand

error_multiplier:
	mov edx, OFFSET error_message_multiplier													;the error_message_multiplier is moved to edx
	call WriteString
	call CrLf																					;A endline is made on console
	call CrLf

	jmp insert_multiplier

ready_for_mult:
	xor eax, eax																				;the registers are cleaned
	xor ebx, ebx
	mov ax, multiplicand																		;multiplicand is moved to the 8 low bit AL register (Acumulator)
	mov bx, multiplier																			;mltiplier is moved to the 8 low bit BL register    (Base register)

	RET

_cli ENDP

END