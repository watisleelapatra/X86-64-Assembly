global _start

section .data
bVar1	db	0x12
bVar2	db	0xaa
wVar1	dw	0x0000
wVar2	dw	0xffee

section .text
_start:
	movzx	cx, byte [bVar1]
	movzx	cx, byte [bVar2]
	movzx	ebx, word [wVar1]
	movzx	ebx, word [wVar2]
	movzx	ebx, cx
	movzx	rbx, cl
	movzx	rbx, cx

	mov	rax, 60	;exit
	mov	rdi, 0
	syscall
