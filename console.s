global	_start
section .data
LF	equ	10
NULL	equ	0
EXIT_SUCCESS equ 0 ; success code
STDIN	equ	0
STDOUT	equ	1
STDERR 	equ	2	
SYS_write equ	1
SYS_exit equ	60
msg1	db	"Hello, World!",LF,NULL
msg2	db	"Enter answer: ",NULL
newLine	db	LF, NULL

section .text
_start:
	mov	rdi, msg1	
	call	printString
	mov	rdi, msg2
	call 	printString
	mov	rdi, newLine
	call 	printString

	mov	rax, SYS_exit		;exit
	mov	rdi, EXIT_SUCCESS
	syscall

global printString
printString:
	push	rbx
	mov	rbx, rdi
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL	;calculate string length
	je	strCountDone
	inc	rdx
	inc	rbx
	jmp	strCountLoop
strCountDone:
	cmp	rdx, 0
	je	prtDone
	mov	rax, SYS_write		;write to console
	mov	rsi, rdi
	mov	rdi, STDOUT
	syscall
prtDone:
	pop	rbx
	ret
