TITLE Program #2     (Project2.asm)

;Author: Tida Sooreechine
;Email: sooreect@oregonstate.edu
;Course: CS271-400 
;Project ID: Program #2
;Assignment Due Date: July 10, 2016
;Description: Program gets user's name and and prints the first n terms of the Fibonacci sequence, 
;	where n is the user's input data, which must be an integer from 1 to 46, inclusive. 

INCLUDE Irvine32.inc


LOWERLIMIT = 1
UPPERLIMIT = 46

.data

userNumber	DWORD	?
num1		DWORD	1
num2		DWORD	1
numCount	DWORD	2

userName	BYTE	33 DUP(0)
title1		BYTE	"Fibonacci Numbers", 0
title2		BYTE	"Programmed by Tida Sooreechine", 0
greet1		BYTE	"What is your name? ", 0
greet2		BYTE	"Hello, ", 0
direction1	BYTE	"Enter the number of Fibonacci terms to be displayed.", 0
direction2	BYTE	"Give the number as an integer in the range [1 . . . 46].", 0
prompt		BYTE	"How many Fibonacci terms would you like to see? ", 0
error		BYTE	"Error: out of range! Please enter a number between 1-46, inclusive.", 0
farewell1	BYTE	"Results certified by Tida Sooreechine", 0
farewell2	BYTE	"Goodbye, ", 0
period		BYTE	".", 0
space		BYTE	"      ", 0


.code
main PROC

;print introduction and greeting messages
	call	clrscr					;clear screen

	mov		edx, OFFSET title1
	call	WriteString
	call	crlf
	mov		edx, OFFSET title2
	call	WriteString
	call	crlf
	call	crlf

	mov		edx, OFFSET greet1
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32					;max length of string acceptable
	call	ReadString
	mov		edx, OFFSET greet2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET period
	call	WriteString
	call	crlf
	call	crlf

;print user instructions
	mov		edx, OFFSET direction1
	call	WriteString
	call	crlf
	mov		edx, OFFSET direction2
	call	WriteString
	call	crlf
	call	crlf

;get and validate user data
validateInput:
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt					;read user input into EAX register
	mov		userNumber, eax			;store input in variable
	cmp		userNumber, LOWERLIMIT	;compare user input to lower limit specified
	jl		errorMessage			;if input is less, proceed to error message area of program
	cmp		userNumber, UPPERLIMIT	;if input passes lower limit test, compare it to upper limit
	jg		errorMessage			;if input is greater, proceed to error message area of program
	call	crlf					;continue with calculation otherwise
	jmp		fibStart

errorMessage:
	mov		edx, OFFSET error
	call	WriteString
	call	crlf 
	call	crlf
	jmp		validateInput

;calculate and print fibonacci numbers
fibStart: 
	mov		edx, OFFSET space	
	cmp		userNumber, 1
	je		printOne
	cmp		userNumber, 2
	je		printTwo
	jmp		printMore

printOne:
	mov		eax, num1
	call	WriteDec
	call	crlf
	call	crlf
	jmp		done

printTwo:
	mov		eax, num1
	call	WriteDec
	call	WriteString
	call	WriteDec
	call	crlf
	call	crlf
	jmp		done

	;print the first two terms
printMore:
	mov		eax, num1
	mov		ecx, userNumber
	sub		ecx, 2					;offset the counter
	call	WriteDec				;print term 1
	call	WriteString				
	call	WriteDec				;print term 2
	call	WriteString				

	;print the remaining numbers in the sequence (userNumber - 2 amount)
	;the next number is the sum of its previous 2 numbers
fibLoop:
	add		eax, num1				;add the two previous terms
	call	WriteDec				;print sum
	mov		ebx, num2				;store variables
	mov		num1, ebx
	mov		num2, eax
	inc		numCount				;increase output count on current line
	cmp		numCount, 5				;where 5 is the max outputs allowed per line
	jge		nextLine				;proceed to the next line if max is reached
	call	WriteString
	jmp		sameLine				;continue on the same line otherwise

nextLine:
	call	crlf
	mov		numCount, 0

sameLine:
	loop	fibLoop					
	call	crlf
	call	crlf

done:

;print farewell messages
	mov		edx, OFFSET farewell1
	call	WriteString
	call	crlf
	mov		edx, OFFSET	farewell2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET period
	call	WriteString
	call	crlf	
	call	crlf

	exit	;exit to operating system
main ENDP

END main