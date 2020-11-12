; ==========Costa Rica Institute of Technology===========
;
; Authors: Eric Alpizar
;		   Rodrigo Espinach
;		   Jimmy Salas
;
; Last date modification: 11/13/2020

include C:\Irvine\Irvine32.inc
includelib C:\Irvine\Irvine32.lib
includelib C:\Irvine\Kernel32.lib
includelib C:\Irvine\user32.lib
include uint8_mult.inc
include cli.inc

.386
.model flat,stdcall
.stack 4096


ExitProcess PROTO, dwExitCode:DWORD

.data
	prompt_0 BYTE "Would you like to calculate again? (Y/N) ", 0	
	validation_prompt BYTE "Invalid option!", 0
	final_message BYTE "Thank you for choosing ´uint8_mult´ calculator", 0	
.code

main PROC

calculation:
CALL CLRSCR
XOR EAX, EAX

INVOKE _cli

INVOKE uint8_mul																				;the uint8_mul is invoked

_display_result prompt_3																		;the result is displayed on console


redo_calculation:

mov edx, OFFSET prompt_0																		;prompt_3 is moved to the edx register
call WriteString																				;edx is printed to screen
call ReadChar																					;single character is read form console
call WriteChar

CALL CRLF																						;an end line is made on console
cmp al, 89D																						;compares character with upper case Y ascii code
je calculation																					;jumps to calculation label

cmp al, 121D																					;121D stands for the ascii code of lowercase y
je calculation


cmp al, 110D																					;110D stands for the ascii code of lowercase n
je _end

cmp al, 78D																						;78D stads fot the ascii code of uppercase N
je _end

mov edx, OFFSET validation_prompt																;validation_prompt is moved to the edx register
call WriteString																				;edx register is displayed on console
call CRLF

jmp redo_calculation																			;jumps to the redo_calculation label

_end:																							;label that indicates the last execution

mov edx, OFFSET final_message																	;final_message is moved to the edx register
call WriteString

INVOKE ExitProcess,0

main ENDP


END main