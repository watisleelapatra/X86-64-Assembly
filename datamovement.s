global	_start

section .data
bVar	db	0
wVar	dw	0
qVar	dq	0

section .text
_start:
	mov	al,0	;al = 
	mov	rbx,0	;rbx = 
	mov	rbx,-1	;rbx =
	mov	rbx,-2	;rbx =
	mov	bl,byte [bVar]	;rbx =
	mov	bx,word [wVar]	;rbx =
	mov	rbx, 0x0123456789abcdef	;rbx =
	mov	qword [qVar], rbx	;qVar =

	mov	rax,60	;exit to console
	mov	rdi,0
	syscall


