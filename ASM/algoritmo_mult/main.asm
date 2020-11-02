include C:\Irvine\Irvine32.inc
includelib C:\Irvine\Irvine32.lib
includelib C:\Irvine\Kernel32.lib
includelib C:\Irvine\user32.lib

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

welcome_message BYTE "Welcome to the multiplication algorithm", 0				;The welcome message is stored

num_1 BYTE ?
num_2 BYTE ?
cont BYTE ?
res BYTE ?
temp DWORD ?


.code

main PROC

menu MACRO welcome_message:REQ

	mov edx, OFFSET welcome_message
	call WriteString
	call CrLf

ENDM

modulo MACRO num_1:REQ, num_2:REQ
							
	MOV CH, CL

	XOR DH, DH						; The dh egister is cleaned using xor
	MOV AH, num_1					; ah register is used as dividend
	MOV CL, num_2					; the divisor or quotient is instantiated in cl
	DIV CL							
	MOV AH, DH						; the remainder is assigned to ah
	MOV CL, CH						; Counter register is restores with the initial value

ENDM


uint8_mult MACRO num_1:REQ, num_2:REQ, res


	mov ah, num_1						; the num_1 is moved to the ah 8 bit counter
	mov bh, num_2						; num_2 is instantiated in bh wich is an 8 bit num_2 register
	mov cl, 0							; the 8 bit count register is assigned to 0
	movzx temp, num_2

	movzx ecx, num_2

	_while:
		
		movzx  temp, ecx

		modulo num_1,num_2				;modulo operation is applied to num_1 and num_2

		cmp ah, 1						; cheks if the remainder is equal to one, this is done to determine if the numbers where even or not

		je _shift_left

			_shift_left:

				shl num_1, cl			; a left shift is done with the value that the counter register has

		inc cl							; Increments the 8 bit counter register
		XOR edx, edx					; The dh egister is cleaned using xor

		mov ah, num_1
		
		mov ebx, 2				
		div ebx							;divides de num_2 by two


		cmp eax, 0

		ja _while

		je endwhile

	endwhile:

		CALL DumpRegs

ENDM

 INVOKE ExitProcess,0

main ENDP


END main