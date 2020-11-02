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
multiplicand BYTE ?
multiplier BYTE ?

.code

main PROC

_cli MACRO welcome_message, prompt_1, prompt_2													;the cli macro is instantiated

	mov edx, OFFSET welcome_message																;the welcolme message is moved to edx
	call WriteString																			;the message is printed in console using Irvine library
	call CrLf																					;A endline is made on console
	call CrLf

	mov edx, OFFSET prompt_1																	
	call WriteString
	CALL ReadHex																				;A number is requested to the user in console
	mov multiplicand, al																		;the low 8 bit register is taken

	xor eax, eax																				;the eax register is cleaned

	mov edx, OFFSET prompt_2																
	call WriteString
	CALL ReadHex																				;the multiplier is read from console
	mov multiplier, al
	CALL CrLf

ENDM

_cli welcome_message, prompt_1, prompt_2														;the cli is excecuted and parameters are asked to the user

xor eax, eax																					;the registers are cleaned
xor ebx, ebx

mov al, multiplicand																			;multiplicand is moved to the 8 low bit AL register (Acumulator)
mov bl, multiplier																				;mltiplier is moved to the 8 low bit BL register    (Base register)


INVOKE uint8_mul																				;the uint8_mul is invoked

CALL DumpRegs																					;registers are showned on console

INVOKE ExitProcess,0

main ENDP


END main