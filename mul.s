global	_start

section .data
	bNumA 	db 15
	bNumB 	db 12
	wAns 	dw 0
	wAns1 	dw 0
	wNumA 	dw 4321
	wNumB 	dw 1234
	dAns2 	dd 0
	dNumA 	dd 42000
	dNumB 	dd 73000
	qAns3 	dq 0
	qNumA 	dq 420000
	qNumB 	dq 730000
	dqAns4 	ddq 0

section .text
_start:
	; wAns = bNumA^2 or bNumA squared
	mov al, byte [bNumA]
	mul al ; result in ax
	mov word [wAns], ax

	; wAns1 = bNumA * bNumB
	mov al, byte [bNumA]
	mul byte [bNumB] ; result in ax
	mov word [wAns1], ax

	; dAns2 = wNumA * wNumB
	mov ax, word [wNumA]
	mul word [wNumB] ; result in dx:ax
	mov word [dAns2], ax
	mov word [dAns2+2], dx

	; qAns3 = dNumA * dNumB
	mov eax, dword [dNumA]
	mul dword [dNumB] ; result in edx:eax
	mov dword [qAns3], eax
	mov dword [qAns3+4], edx

	; dqAns4 = qNumA * qNumB
	mov rax, qword [qNumA]
	mul qword [qNumB] ; result in rdx:rax
	mov qword [dqAns4], rax
	mov qword [dqAns4+8], rdx

	mov rax, 60	;exit
	mov rdi, 0
	syscall

