global	_start
section .data
LF      equ     10
NULL    equ     0
EXIT_SUCCESS equ 0 ; success code
STDIN   equ     0
STDOUT  equ     1
STDERR  equ     2
SYS_read  equ	0	
SYS_write equ   1
SYS_exit equ    60
msg     db      "Enter name: ", NULL
newLine db      LF, NULL

section .bss
buffer	resb	255	;input buffer

section .text
_start:
	mov     rdi, msg	;display message
        call    printString
        mov	rdi, STDIN	;read from keyboard
	mov	rsi, buffer	;save keyboard input to buffer
	mov	rax, SYS_read	;call system read routine
	mov	rdx, 10		;read 10 characters
	syscall
	
	mov	rsi, buffer	;display buffer
	mov	rax, SYS_write
	mov	rdi, STDOUT
	mov	rdx, 10		;print 10 characters
	syscall

	mov	rdi, newLine
	call	printString	

	mov	rax, SYS_exit	;exit
	mov     rdi, EXIT_SUCCESS
	syscall

global printString
printString:
        push    rbx
        mov     rbx, rdi
        mov     rdx, 0
strCountLoop:
        cmp     byte [rbx], NULL        ;calculate string length
        je      strCountDone
        inc     rdx
        inc     rbx
        jmp     strCountLoop
strCountDone:
        cmp     rdx, 0
        je      prtDone
        mov     rax, SYS_write          ;write to console
        mov     rsi, rdi
        mov     rdi, STDOUT
        syscall
prtDone:
        pop     rbx
        ret

