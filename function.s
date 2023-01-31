global _start
section .data
	msg 	db	"Assembly Language Programming", 0x00
	slen	db	0

section .text
_start:
	mov	rax, msg	;load EAX with msg addr
	call	strlen		;call string length function

	mov	qword [slen], rax
	mov	rax, 60		;exit
	mov	rdi, 0
	syscall
strlen:
	push	rbx		;save EBX
	mov	rbx, rax
nextchar:
	cmp	qword [rax], 0	;compare to NULL
	jz	finish		
	inc	rax
	jmp	nextchar	
finish:
	sub	rax, rbx	;[last char] - [first char] 
	pop	rbx	
	ret
	

