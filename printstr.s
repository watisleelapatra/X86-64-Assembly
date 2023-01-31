global printString
NULL 		equ	0
SYS_write	equ	1
STDOUT		equ	1
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

