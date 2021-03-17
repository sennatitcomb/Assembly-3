TITLE Project3 Program(template.asm)

; Author: Senna Titcomb
; Last Modified : 1 / 26 / 2021
; OSU email address : titcombs@oregonstate.edu
; Course number / section: 271 / 001
; Assignment Number : Program 3                Due Date : Jan 24
; Description: Do the following : Implementing datum validation,
; Implementing an accumulator, Integer arithmetic,
; Defining integer and string, Using  I / O library procedures, Implementing control structures

INCLUDE Irvine32.inc


; (insert constant definitions here)

.data
; (insert variable definitions here)
	titlemessage BYTE "Welcome to the Integer Accumulator by Senna Titcomb", 0dh, 0ah, 0
	namemessage BYTE "What's your name?", 0dh, 0ah, 0
	greeting BYTE "Hello, ", 0
	instruction1 BYTE "Please enter numbers in [-100, -1]", 0
	instruction2 BYTE "Enter a non-negative number when you are finished to see results.", 0
	getvalue BYTE "Enter number: ", 0
	error BYTE "Invalid numbers, please enter numbers in  [-100, -1]", 0dh, 0ah, 0
	result BYTE "Thank you for playing Integer Accumulator!", 0dh, 0ah, 0
	goodbye BYTE "Goodbye, ", 0
	valid BYTE "You have ", 0
	valid2 BYTE " valid numbers.", 0dh, 0ah, 0
	novalid BYTE "Wow! There were no valid numbers!", 0dh, 0ah, 0
	summess BYTE "The sum of your valid nums is ", 0
	avgmess BYTE "The rounded average is ", 0
	usernamebuffer BYTE 21 DUP(0)
	username BYTE 21 DUP(0)
	value SDWORD ?
	avg DWORD 0
	upperlimit DWORD 0
	lowerlimit DWORD -100
	counter SDWORD 0
	total DWORD 0
	

.code
main PROC
	call Clrscr

; print titlemessage
	mov edx, OFFSET titlemessage
	call WriteString

; print namemessage and get username
	mov edx, OFFSET namemessage
	call WriteString
	call Crlf
	mov edx, OFFSET greeting  ;print greeting
	call WriteString
	mov edx, OFFSET username
	mov ecx, SIZEOF usernamebuffer	;specifies max characters
	call ReadString			;takes username

; print instructions
	mov edx, OFFSET instruction1
	call WriteString
	call Crlf
	mov edx, OFFSET instruction2
	call WriteString
	call Crlf
	
; is input valid?
validLoop: 
		mov edx, OFFSET getvalue
		call WriteString
		call ReadInt
		mov value, eax
		mov eax, value
		cmp eax, lowerlimit		;is value greater than -100?
		jle invalid			;less than jump to error
		cmp eax, upperlimit		;is value less than -1?
		jge finish			;greater than jump to error message
		add eax, total
		mov total, eax
		inc counter
		jmp validLoop			;get another num
	invalid:
		mov edx, OFFSET error
		call WriteString
		jmp validLoop	;invalid num, ask again
	finish:
		mov eax, counter
		cmp eax, 0
		jle notvalid

	;print num of valid
	mov edx, OFFSET valid
	call WriteString
	mov eax, counter
	call WriteInt
	mov edx, OFFSET valid2
	call WriteString

;begin calculations
	mov edx, OFFSET summess
	call WriteString
	mov eax, total		;prints sum
	call WriteInt
	call Crlf
	mov edx, OFFSET avgmess
	call WriteString
	neg total			;change sign
	mov eax, total
	cdq
	mov ebx, counter
	div ebx				;divide to get avg
	mov avg, eax	
	mov eax, edx
	add eax, eax
	cmp eax, counter
	jl less
	inc avg		;round if greater
less:
	mov eax, avg
	neg eax
	call WriteInt
	call Crlf
	jmp endofprogram

notvalid:
	mov edx, OFFSET novalid
	call WriteString

;print goodbye to user
endofprogram:
	call Crlf
	mov edx, OFFSET result
	call WriteString
	mov edx, OFFSET goodbye
	call WriteString
	mov edx, OFFSET username
	call WriteString


; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
