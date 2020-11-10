include C:\Irvine\Irvine32.inc
includelib C:\Irvine\Irvine32.lib
includelib C:\Irvine\Kernel32.lib
includelib C:\Irvine\user32.lib
include uint8_mult.inc

; Tecnologico de Costa Rica
;
; Authors: Eric Alpizar
;		   Rodrigo Espinach
;		   Jimmy Salas
;
; Last date modification: 10/31/2020

.386
.model flat,stdcall
.stack 4096


ExitProcess PROTO, dwExitCode:DWORD

.data

welcome_message BYTE "----------Welcome to the uint8_mult algorithm----------", 0				;The welcome message is stored
prompt_1 BYTE "Please enter the multiplicand: ", 0												; Prompts are saved
prompt_2 BYTE "Please enter the multiplier: ", 0
prompt_3 BYTE "The result is: ",0
error_message_multiplicand BYTE "Error with the multiplicand please enter the number again",0		;error message for multiplicand
error_message_multiplier BYTE "Error with the multiplier please enter the number again",0			;error message for multiplier
multiplicand BYTE ?
multiplier BYTE ?

.code

main PROC


error_multiplicand:
	mov edx, OFFSET error_message_multiplicand																;the error_message_multiplicand is moved to edx
	call WriteString
	call CrLf																					;A endline is made on console
	call CrLf

	jmp insert_multiplicando

error_multiplier:
	mov edx, OFFSET error_message_multiplier																;the error_message_multiplier is moved to edx
	call WriteString
	call CrLf																					;A endline is made on console
	call CrLf

	jmp insert_multiplier

_display_result MACRO prompt_3:REQ

	mov edx, OFFSET prompt_3																	;prompt_3 is moved to the edx register
	call WriteString																			; edx is printed to screen
	call WriteDec																				;display the eax register in decimal value
	CALL CrLf

ENDM

welcome:
	mov edx, OFFSET welcome_message																;the welcolme message is moved to edx
	call WriteString																			;the message is printed in console using Irvine library
	call CrLf																					;A endline is made on console
	call CrLf

insert_multiplicando:
	xor eax, eax

	mov edx, OFFSET prompt_1																	
	call WriteString
	CALL ReadInt																				;A number is requested to the user in console
	cmp multiplicand, 255
	ja error_multiplicand
	mov multiplicand, eax																		;the low 8 bit register is taken

	cmp 2, 1

insert_multiplier:
	xor eax, eax																				;the eax register is cleaned

	mov edx, OFFSET prompt_2																
	call WriteString
	CALL ReadInt																				;the multiplier is read from console
	cmp multiplier, 255																			;check the multiplier is a number of 8 bits at most
	ja error_multiplier
	mov multiplier, eax
	CALL CrLf													;the cli is excecuted and parameters are asked to the user

ready_for_mult:
	xor eax, eax																					;the registers are cleaned
	xor ebx, ebx

	mov al, multiplicand																			;multiplicand is moved to the 8 low bit AL register (Acumulator)
	mov bl, multiplier																				;mltiplier is moved to the 8 low bit BL register    (Base register)




INVOKE uint8_mul																				;the uint8_mul is invoked

_display_result prompt_3																		;the result is displayed on console

INVOKE ExitProcess,0

main ENDP


END main