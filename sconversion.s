global _start

section .data
bVar1	db	0x12
bVar2	db	0xaa
wVar1	dw	0x0000
wVar2	dw	0xffee

section .text
_start:
	movsx	cx, byte [bVar1]
	movsx	cx, byte [bVar2]
	movsx	ebx, word [wVar1]
	movsx	ebx, word [wVar2]
	movsx	ebx, cx
	movsx	rbx, cl
	movsx	rbx, cx

	mov	rax, 60	;exit
	mov	rdi, 0
	syscall
