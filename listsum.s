section .data
	; Define constants
	EXIT_SUCCESS 	equ 0 ; successful operation
	SYS_exit 	equ 60 ; call code for terminate

section .data
	lst dd 1002, 1004, 1006, 1008, 10010
	len dd 5
	sum dd 0

section .text
global _start
_start:
	; Summation loop.
	mov ecx, dword [len] 	; get length value
	mov rsi, 0 		; index=0
sumLoop:
	mov eax, dword [lst+(rsi*4)] ; get lst[rsi]
	add dword [sum], eax 	; update sum
	inc rsi 		; next item
	loop sumLoop
	mov rax, SYS_exit 	; call code for exit
	mov rdi, EXIT_SUCCESS 	; exit with success
	syscall
