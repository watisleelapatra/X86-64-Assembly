global	_start

section	.text			;code section
_start:				;start label
	mov	rax,1		;call stdout
	mov	rdi,1
	mov	rsi,msg		;pointer to starting address of message
	mov	rdx,msglen	;length of message
	syscall			;execute system routine
	mov	rax,60		;exit
	mov	rdi,0
	syscall	

section .data
msg	db	"Hello, world!"
msglen	equ	$-msg
