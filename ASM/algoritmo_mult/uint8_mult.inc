; ==========Costa Rica Institute of Technology===========
; Authors: Eric Alpizar
;		   Rodrigo Espinach
;		   Jimmy Salas
; Last date modified: 11/3/2020



;-----------------------------------------------------------------------------
; UINT8_MULT PROC
; Calculates the multiplication of to given 8 bit numbers
; Recieves: al = multiplicand
;			bl = multiplier
; Returns:	EAX = product
;-----------------------------------------------------------------------------


.data

num_1 WORD ?
num_2 BYTE ?
res WORD ?
temp BYTE ?


.code

uint8_mul PROC

modulo MACRO temp:REQ						

	PUSH CX

	XOR DX, DX							; The dh register is cleaned using xor
	MOV AL, temp						; al register is used as dividend
	AND AL, 1							; logical and operation is applied to AL

	POP CX								; Counter register is restores with the initial value								

ENDM

	mov num_1, AX						; the numbers to multiply are instatiated here (TEMPORARY)
	mov num_2, bl
	
	xor bx, bx							; bx, cl and ax registers are cleaned
	xor cl, cl
	xor ax, ax
	mov res, 0

	movzx ax, num_2

	_while:
		
		mov  temp, al

		push ax							;ax register is pushed to the stack

		modulo temp						;modulo operation is applied to temp and 2

		cmp ax, 1						;cheks if the remainder is equal to one, this is done to find out if the numbers are even or not

		je _shift_left					;jump to _shift_left if ax is equal to 1

		_continue:

		OR AX, 1

		pop ax							;ax register is back to its original value before applying modulo

		inc cl							;Increments the 8 bit counter register

		SHR AX, 1						;bitwise shift one space to the right (ax / 2)

		cmp AX, 0						;compares ax to 0

		ja _while					    ;jump to the _while segment if ax is above 0

		jbe endwhile					;jump the the end_while segment if ax is equal or bellow 0

	_shift_left:

		push bx							;the 16 bit bx register is pushed to the stack to save its value
		mov AX, num_1					;num_1 is stored in the al registered before doing logical shift

		xor bl,bl						;bl register is cleaned

		shl num_1, cl					;a left shift is done with the value that the counter register has

		mov BX, res						;the temporary result is moved to the bl register
		add BX, num_1					;current value of num_1 is added to bl
		mov res, BX			

		mov num_1, AX					;the original value of num_1 before the shift is applied
		pop bx							;the value of bx is restored

		jmp _continue					;always jumps to the continue segment


	endwhile:							;the segment where it ends the loop

		movzx eax, res					;move the result to eax

	RET 

uint8_mul ENDP

