global	_start
section .data

section .text
_start:
	mov	rdi, 1	;first argument
	mov	rsi, 2	;second argument
	mov	rdx, 3	;third argument
	call	func	

	mov	rax, 60	;exit
	mov	rdi, 0
	syscall

func:	push	rbx	 ;save content of RBX
	push	rcx	 ;save content of RCX
	mov	rax, rdi ;utilize 1st arg
	mov	rbx, rsi ;utilize 2nd arg
	mov	rcx, rdx ;utilize 3rd arg
	add	rax, rbx
	add 	rax, rcx ;return value in RAX
	pop	rcx
	pop	rbx
	ret
