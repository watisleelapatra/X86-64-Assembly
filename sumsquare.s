; sum of squares from 1 to n.
section .data
	SUCCESS 	equ 0 ; Successful operation
	SYS_exit 	equ 60 ; call code for terminate
	n 		dd 10
	sumOfSquares dq 0
section .text
global _start
_start:
; -----
; Compute sum of squares from 1 to n.
; Approach:
; for (i=1; i<n; i++)
; sumOfSquares += i^2;
	mov rbx, 1 		; i
	mov ecx, dword [n]
sumLoop:
	mov rax, rbx 		; get i
	mul rax 		; i^2
	add qword [sumOfSquares], rax
	inc rbx
	loop sumLoop
last:
	mov rax, SYS_exit 	; call code for exit
	mov rdi, SUCCESS 
	syscall
