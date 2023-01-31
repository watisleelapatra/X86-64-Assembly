section .data
; -----
; Define standard constants.
LF 	equ 10 	; line feed
NULL 	equ 0 	; end of string
TRUE 	equ 1
FALSE 	equ 0
EXIT_SUCCESS equ 0 ; success code
STDIN 	equ 0 	; standard input
STDOUT 	equ 1 	; standard output
STDERR 	equ 2 	; standard error
SYS_read equ 0 	; read
SYS_write equ 1 ; write
SYS_open equ 2 	; file open
SYS_close equ 3 ; file close
SYS_fork equ 57 ; fork
SYS_exit equ 60 ; terminate
SYS_creat equ 85 ; file open/create
SYS_time equ 201 ; get time
O_CREAT equ 0x40
O_TRUNC equ 0x200
O_APPEND equ 0x400
O_RDONLY equ 000000q ; read only
O_WRONLY equ 000001q ; write only
O_RDWR 	equ 000002q ; read and write
S_IRUSR equ 00400q
S_IWUSR equ 00200q
S_IXUSR equ 00100q
; -----
; Variables for main.
newLine db LF, NULL
header 	db LF, "File Write Example."
	db LF, LF, NULL
fileName db "url.txt", NULL
url 	db "http://www.google.com"
	db LF, NULL
len 	dq $-url-1
writeDone 	db "Write Completed.", LF, NULL
fileDescrip 	dq 0
errMsgOpen 	db "Error opening file.", LF, NULL
errMsgWrite 	db "Error writing to file.", LF, NULL
;--------------------------------------------------------
section .text
global _start
_start:
; Display header line...
	mov rdi, header
	call printString
; -----
; Attempt to open file.
; Use system service for file open
; System Service - Open/Create
; rax = SYS_creat (file open/create)
; rdi = address of file name string
; rsi = attributes (i.e., read only, etc.)
; Returns:
; if error -> eax < 0
; if success -> eax = file descriptor number
; The file descriptor points to the File Control
; Block (FBC). The FCB is maintained by the OS.
; The file descriptor is used for all subsequent
; file operations (read, write, close).
openInputFile:
	mov rax, SYS_creat ; file open/create
	mov rdi, fileName ; file name string
	mov rsi, S_IRUSR | S_IWUSR ; allow read/write
	syscall ; call the kernel
	cmp rax, 0 ; check for success
	jl errorOnOpen
	mov qword [fileDescrip], rax ; save descriptor
; -----
; Write to file.
; In this example, the characters to write are in a
; predefined string containing a URL.
; System Service - write
; rax = SYS_write
; rdi = file descriptor
; rsi = address of characters to write
; rdx = count of characters to write
; Returns:
; if error -> rax < 0
; if success -> rax = count of characters actually read
	mov rax, SYS_write
	mov rdi, qword [fileDescrip]
	mov rsi, url
	mov rdx, qword [len]
	syscall
	cmp rax, 0
	jl errorOnWrite
	mov rdi, writeDone
	call printString
	jmp exampleDone
; -----
; Close the file.
; System Service - close
; rax = SYS_close
; rdi = file descriptor
	mov rax, SYS_close
	mov rdi, qword [fileDescrip]
	syscall
	jmp exampleDone
; -----
; Error on open.
; note, rax contains an error code which is not used for this example.
errorOnOpen:
	mov rdi, errMsgOpen
	call printString
	jmp exampleDone
; -----
; Error on write.
; note, rax contains an error code which is not used for this example.
errorOnWrite:
	mov rdi, errMsgWrite
	call printString
	jmp exampleDone
; -----
; Example program done.
exampleDone:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
global printString
printString:
	push rbp
	mov rbp, rsp
	push rbx
; -----
; Count characters in string.
	mov rbx, rdi
	mov rdx, 0
	strCountLoop:
	cmp byte [rbx], NULL
	je strCountDone
	inc rdx
	inc rbx
	jmp strCountLoop
strCountDone:
	cmp rdx, 0
	je prtDone
; -----
; Call OS to output string.
	mov eax, SYS_write ; code for write()
	mov rsi, rdi ; addr of characters
	mov rdi, STDOUT ; file descriptor
	syscall ; system call
; -----
; String printed, return to calling routine.
prtDone:
	pop rbx
	pop rbp
	ret

